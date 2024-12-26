defmodule MorphicPro.Projects.Project do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "projects" do
    field :status, Ecto.Enum, values: [:draft, :started, :completed, :closed]
    field :title, :string
    field :body, :string
    field :for_oganization_id, :binary_id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(project, attrs) do
    project
    |> cast(attrs, [:title, :body, :status])
    |> validate_required([:title, :body, :status])
  end
end
