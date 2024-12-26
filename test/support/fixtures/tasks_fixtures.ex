defmodule MorphicPro.TasksFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `MorphicPro.Tasks` context.
  """

  @doc """
  Generate a task.
  """
  def task_fixture(attrs \\ %{}) do
    {:ok, task} =
      attrs
      |> Enum.into(%{
        body: "some body",
        status: :todo,
        title: "some title"
      })
      |> MorphicPro.Tasks.create_task()

    task
  end
end
