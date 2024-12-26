defmodule MorphicPro.Quotes.Quote do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "quotes" do
    field :status, Ecto.Enum, values: [:draft, :sent, :viewed, :accepted, :rejected]
    field :for_rfp_id, :binary_id
    field :for_user_id, :binary_id
    field :for_organization_id, :binary_id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(quote, attrs) do
    quote
    |> cast(attrs, [:status])
    |> validate_required([:status])
  end
end
