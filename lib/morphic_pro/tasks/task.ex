defmodule MorphicPro.Tasks.Task do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "tasks" do
    field :status, Ecto.Enum, values: [:todo, :in_progress, :done, :wont_do, :archived]
    field :body, :string
    field :title, :string
    field :for_by_user_id, :binary_id
    field :for_project_id, :binary_id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(task, attrs) do
    task
    |> cast(attrs, [:title, :body, :status])
    |> validate_required([:title, :body, :status])
  end
end
