defmodule MorphicPro.Repo.Migrations.CreateRequestForProposals do
  use Ecto.Migration

  def change do
    create table(:request_for_proposals, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :status, :string
      add :for_user_id, references(:users, on_delete: :nothing, type: :binary_id)
      add :for_organization_id, references(:organizations, on_delete: :nothing, type: :binary_id)

      timestamps(type: :utc_datetime)
    end

    create index(:request_for_proposals, [:for_user_id])
    create index(:request_for_proposals, [:for_organization_id])
  end
end
