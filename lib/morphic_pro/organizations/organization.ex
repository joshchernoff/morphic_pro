defmodule MorphicPro.Organizations.Organization do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "organizations" do
    field :description, :string
    field :title, :string
    field :for_user_id, :binary_id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(organization, attrs) do
    organization
    |> cast(attrs, [:title, :description])
    |> validate_required([:title, :description])
  end
end
