defmodule MorphicPro.Repo.Migrations.CreateQuotes do
  use Ecto.Migration

  def change do
    create table(:quotes, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :status, :string
      add :for_rfp_id, references(:request_for_proposals, on_delete: :nothing, type: :binary_id)
      add :for_user_id, references(:users, on_delete: :nothing, type: :binary_id)
      add :for_organization_id, references(:organizations, on_delete: :nothing, type: :binary_id)

      timestamps(type: :utc_datetime)
    end

    create index(:quotes, [:for_rfp_id])
    create index(:quotes, [:for_user_id])
    create index(:quotes, [:for_organization_id])
  end
end
