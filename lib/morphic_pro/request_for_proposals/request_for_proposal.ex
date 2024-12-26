defmodule MorphicPro.RequestForProposals.RequestForProposal do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "request_for_proposals" do
    field :status, Ecto.Enum, values: [:requested, :reviewing, :qouted, :rejected]
    field :for_user_id, :binary_id
    field :for_organization_id, :binary_id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(request_for_proposal, attrs) do
    request_for_proposal
    |> cast(attrs, [:status])
    |> validate_required([:status])
  end
end
