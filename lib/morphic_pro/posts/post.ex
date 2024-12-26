defmodule MorphicPro.Posts.Post do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "post" do
    field :description, :string
    field :title, :string
    field :body, :string
    field :published_at, :naive_datetime

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:title, :body, :description, :published_at])
    |> validate_required([:title, :body, :description, :published_at])
  end
end
