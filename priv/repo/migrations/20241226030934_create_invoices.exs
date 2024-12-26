defmodule MorphicPro.Repo.Migrations.CreateInvoices do
  use Ecto.Migration

  def change do
    create table(:invoices, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :status, :string
      add :for_user_id, references(:users, on_delete: :nothing, type: :binary_id)
      add :for_organization_id, references(:organizations, on_delete: :nothing, type: :binary_id)
      add :for_quote_id, references(:quotes, on_delete: :nothing, type: :binary_id)

      timestamps(type: :utc_datetime)
    end

    create index(:invoices, [:for_user_id])
    create index(:invoices, [:for_organization_id])
    create index(:invoices, [:for_quote_id])
  end
end
