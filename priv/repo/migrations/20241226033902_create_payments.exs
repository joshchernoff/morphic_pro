defmodule MorphicPro.Repo.Migrations.CreatePayments do
  use Ecto.Migration

  def change do
    create table(:payments, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :total, :integer
      add :for_user_id, references(:users, on_delete: :nothing, type: :binary_id)
      add :for_invoice_id, references(:invoices, on_delete: :nothing, type: :binary_id)

      timestamps(type: :utc_datetime)
    end

    create index(:payments, [:for_user_id])
    create index(:payments, [:for_invoice_id])
  end
end
