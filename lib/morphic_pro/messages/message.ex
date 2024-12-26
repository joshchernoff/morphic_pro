defmodule MorphicPro.Messages.Message do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "massages" do
    field :title, :string
    field :body, :string
    field :for_user_id, :binary_id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(message, attrs) do
    message
    |> cast(attrs, [:title, :body])
    |> validate_required([:title, :body])
  end
end
