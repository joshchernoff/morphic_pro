defmodule MorphicPro.RequestForProposalsTest do
  use MorphicPro.DataCase

  alias MorphicPro.RequestForProposals

  describe "request_for_proposals" do
    alias MorphicPro.RequestForProposals.RequestForProposal

    import MorphicPro.RequestForProposalsFixtures

    @invalid_attrs %{status: nil}

    test "list_request_for_proposals/0 returns all request_for_proposals" do
      request_for_proposal = request_for_proposal_fixture()
      assert RequestForProposals.list_request_for_proposals() == [request_for_proposal]
    end

    test "get_request_for_proposal!/1 returns the request_for_proposal with given id" do
      request_for_proposal = request_for_proposal_fixture()

      assert RequestForProposals.get_request_for_proposal!(request_for_proposal.id) ==
               request_for_proposal
    end

    test "create_request_for_proposal/1 with valid data creates a request_for_proposal" do
      valid_attrs = %{status: :requested}

      assert {:ok, %RequestForProposal{} = request_for_proposal} =
               RequestForProposals.create_request_for_proposal(valid_attrs)

      assert request_for_proposal.status == :requested
    end

    test "create_request_for_proposal/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} =
               RequestForProposals.create_request_for_proposal(@invalid_attrs)
    end

    test "update_request_for_proposal/2 with valid data updates the request_for_proposal" do
      request_for_proposal = request_for_proposal_fixture()
      update_attrs = %{status: :reviewing}

      assert {:ok, %RequestForProposal{} = request_for_proposal} =
               RequestForProposals.update_request_for_proposal(request_for_proposal, update_attrs)

      assert request_for_proposal.status == :reviewing
    end

    test "update_request_for_proposal/2 with invalid data returns error changeset" do
      request_for_proposal = request_for_proposal_fixture()

      assert {:error, %Ecto.Changeset{}} =
               RequestForProposals.update_request_for_proposal(
                 request_for_proposal,
                 @invalid_attrs
               )

      assert request_for_proposal ==
               RequestForProposals.get_request_for_proposal!(request_for_proposal.id)
    end

    test "delete_request_for_proposal/1 deletes the request_for_proposal" do
      request_for_proposal = request_for_proposal_fixture()

      assert {:ok, %RequestForProposal{}} =
               RequestForProposals.delete_request_for_proposal(request_for_proposal)

      assert_raise Ecto.NoResultsError, fn ->
        RequestForProposals.get_request_for_proposal!(request_for_proposal.id)
      end
    end

    test "change_request_for_proposal/1 returns a request_for_proposal changeset" do
      request_for_proposal = request_for_proposal_fixture()

      assert %Ecto.Changeset{} =
               RequestForProposals.change_request_for_proposal(request_for_proposal)
    end
  end
end
