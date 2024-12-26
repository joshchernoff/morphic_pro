defmodule MorphicPro.PaymentsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `MorphicPro.Payments` context.
  """

  @doc """
  Generate a payment.
  """
  def payment_fixture(attrs \\ %{}) do
    {:ok, payment} =
      attrs
      |> Enum.into(%{
        total: 0
      })
      |> MorphicPro.Payments.create_payment()

    payment
  end
end
