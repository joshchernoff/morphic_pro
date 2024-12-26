defmodule MorphicPro.RequestForProposals do
  @moduledoc """
  The RequestForProposals context.
  """

  import Ecto.Query, warn: false
  alias MorphicPro.Repo

  alias MorphicPro.RequestForProposals.RequestForProposal

  @doc """
  Returns the list of request_for_proposals.

  ## Examples

      iex> list_request_for_proposals()
      [%RequestForProposal{}, ...]

  """
  def list_request_for_proposals do
    Repo.all(RequestForProposal)
  end

  @doc """
  Gets a single request_for_proposal.

  Raises `Ecto.NoResultsError` if the Request for proposal does not exist.

  ## Examples

      iex> get_request_for_proposal!(123)
      %RequestForProposal{}

      iex> get_request_for_proposal!(456)
      ** (Ecto.NoResultsError)

  """
  def get_request_for_proposal!(id), do: Repo.get!(RequestForProposal, id)

  @doc """
  Creates a request_for_proposal.

  ## Examples

      iex> create_request_for_proposal(%{field: value})
      {:ok, %RequestForProposal{}}

      iex> create_request_for_proposal(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_request_for_proposal(attrs \\ %{}) do
    %RequestForProposal{}
    |> RequestForProposal.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a request_for_proposal.

  ## Examples

      iex> update_request_for_proposal(request_for_proposal, %{field: new_value})
      {:ok, %RequestForProposal{}}

      iex> update_request_for_proposal(request_for_proposal, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_request_for_proposal(%RequestForProposal{} = request_for_proposal, attrs) do
    request_for_proposal
    |> RequestForProposal.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a request_for_proposal.

  ## Examples

      iex> delete_request_for_proposal(request_for_proposal)
      {:ok, %RequestForProposal{}}

      iex> delete_request_for_proposal(request_for_proposal)
      {:error, %Ecto.Changeset{}}

  """
  def delete_request_for_proposal(%RequestForProposal{} = request_for_proposal) do
    Repo.delete(request_for_proposal)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking request_for_proposal changes.

  ## Examples

      iex> change_request_for_proposal(request_for_proposal)
      %Ecto.Changeset{data: %RequestForProposal{}}

  """
  def change_request_for_proposal(%RequestForProposal{} = request_for_proposal, attrs \\ %{}) do
    RequestForProposal.changeset(request_for_proposal, attrs)
  end
end
