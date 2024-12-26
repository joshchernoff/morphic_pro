defmodule MorphicPro.Comments.Comment do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "comments" do
    field :status, Ecto.Enum, values: [:in_review, :published, :moderated]
    field :body, :string
    field :for_user_id, :binary_id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(comment, attrs) do
    comment
    |> cast(attrs, [:body, :status])
    |> validate_required([:body, :status])
  end
end
