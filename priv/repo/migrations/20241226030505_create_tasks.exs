defmodule MorphicPro.Repo.Migrations.CreateTasks do
  use Ecto.Migration

  def change do
    create table(:tasks, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :title, :string
      add :body, :text
      add :status, :string
      add :for_by_user_id, references(:users, on_delete: :nothing, type: :binary_id)
      add :for_project_id, references(:projects, on_delete: :nothing, type: :binary_id)

      timestamps(type: :utc_datetime)
    end

    create index(:tasks, [:for_by_user_id])
    create index(:tasks, [:for_project_id])
  end
end
