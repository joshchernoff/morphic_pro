defmodule MorphicPro.QuotesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `MorphicPro.Quotes` context.
  """

  @doc """
  Generate a quote.
  """
  def quote_fixture(attrs \\ %{}) do
    {:ok, quote} =
      attrs
      |> Enum.into(%{
        status: :draft
      })
      |> MorphicPro.Quotes.create_quote()

    quote
  end
end
