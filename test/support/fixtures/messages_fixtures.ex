defmodule MorphicPro.MessagesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `MorphicPro.Messages` context.
  """

  @doc """
  Generate a message.
  """
  def message_fixture(attrs \\ %{}) do
    {:ok, message} =
      attrs
      |> Enum.into(%{
        body: "some body",
        title: "some title"
      })
      |> MorphicPro.Messages.create_message()

    message
  end
end
