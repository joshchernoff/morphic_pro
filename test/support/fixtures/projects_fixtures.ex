defmodule MorphicPro.ProjectsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `MorphicPro.Projects` context.
  """

  @doc """
  Generate a project.
  """
  def project_fixture(attrs \\ %{}) do
    {:ok, project} =
      attrs
      |> Enum.into(%{
        body: "some body",
        status: :draft,
        title: "some title"
      })
      |> MorphicPro.Projects.create_project()

    project
  end
end
