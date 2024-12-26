defmodule MorphicPro.InvoicesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `MorphicPro.Invoices` context.
  """

  @doc """
  Generate a invoice.
  """
  def invoice_fixture(attrs \\ %{}) do
    {:ok, invoice} =
      attrs
      |> Enum.into(%{
        status: :draft
      })
      |> MorphicPro.Invoices.create_invoice()

    invoice
  end
end
