defmodule MorphicPro.ProjectsTest do
  use MorphicPro.DataCase

  alias MorphicPro.Projects

  describe "projects" do
    alias MorphicPro.Projects.Project

    import MorphicPro.ProjectsFixtures

    @invalid_attrs %{status: nil, title: nil, body: nil}

    test "list_projects/0 returns all projects" do
      project = project_fixture()
      assert Projects.list_projects() == [project]
    end

    test "get_project!/1 returns the project with given id" do
      project = project_fixture()
      assert Projects.get_project!(project.id) == project
    end

    test "create_project/1 with valid data creates a project" do
      valid_attrs = %{status: :draft, title: "some title", body: "some body"}

      assert {:ok, %Project{} = project} = Projects.create_project(valid_attrs)
      assert project.status == :draft
      assert project.title == "some title"
      assert project.body == "some body"
    end

    test "create_project/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Projects.create_project(@invalid_attrs)
    end

    test "update_project/2 with valid data updates the project" do
      project = project_fixture()
      update_attrs = %{status: :started, title: "some updated title", body: "some updated body"}

      assert {:ok, %Project{} = project} = Projects.update_project(project, update_attrs)
      assert project.status == :started
      assert project.title == "some updated title"
      assert project.body == "some updated body"
    end

    test "update_project/2 with invalid data returns error changeset" do
      project = project_fixture()
      assert {:error, %Ecto.Changeset{}} = Projects.update_project(project, @invalid_attrs)
      assert project == Projects.get_project!(project.id)
    end

    test "delete_project/1 deletes the project" do
      project = project_fixture()
      assert {:ok, %Project{}} = Projects.delete_project(project)
      assert_raise Ecto.NoResultsError, fn -> Projects.get_project!(project.id) end
    end

    test "change_project/1 returns a project changeset" do
      project = project_fixture()
      assert %Ecto.Changeset{} = Projects.change_project(project)
    end
  end
end
