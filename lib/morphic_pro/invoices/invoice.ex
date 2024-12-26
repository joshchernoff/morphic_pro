defmodule MorphicPro.Invoices.Invoice do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "invoices" do
    field :status, Ecto.Enum, values: [:draft, :sent, :viewed, :paied, :past_due]
    field :for_user_id, :binary_id
    field :for_organization_id, :binary_id
    field :for_quote_id, :binary_id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(invoice, attrs) do
    invoice
    |> cast(attrs, [:status])
    |> validate_required([:status])
  end
end
