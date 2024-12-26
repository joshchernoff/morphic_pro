defmodule MorphicPro.Repo.Migrations.CreateMassages do
  use Ecto.Migration

  def change do
    create table(:massages, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :title, :string
      add :body, :text
      add :for_user_id, references(:users, on_delete: :nothing, type: :binary_id)

      timestamps(type: :utc_datetime)
    end

    create index(:massages, [:for_user_id])
  end
end
