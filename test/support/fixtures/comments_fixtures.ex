defmodule MorphicPro.CommentsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `MorphicPro.Comments` context.
  """

  @doc """
  Generate a comment.
  """
  def comment_fixture(attrs \\ %{}) do
    {:ok, comment} =
      attrs
      |> Enum.into(%{
        body: "some body",
        status: :in_review
      })
      |> MorphicPro.Comments.create_comment()

    comment
  end
end
