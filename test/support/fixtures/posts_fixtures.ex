defmodule MorphicPro.PostsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `MorphicPro.Posts` context.
  """

  @doc """
  Generate a post.
  """
  def post_fixture(attrs \\ %{}) do
    {:ok, post} =
      attrs
      |> Enum.into(%{
        body: "some body",
        description: "some description",
        published_at: ~N[2024-12-25 03:06:00],
        title: "some title"
      })
      |> MorphicPro.Posts.create_post()

    post
  end
end
