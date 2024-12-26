defmodule MorphicPro.RequestForProposalsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `MorphicPro.RequestForProposals` context.
  """

  @doc """
  Generate a request_for_proposal.
  """
  def request_for_proposal_fixture(attrs \\ %{}) do
    {:ok, request_for_proposal} =
      attrs
      |> Enum.into(%{
        status: :requested
      })
      |> MorphicPro.RequestForProposals.create_request_for_proposal()

    request_for_proposal
  end
end
