defmodule MorphicPro.Repo.Migrations.CreatePost do
  use Ecto.Migration

  def change do
    create table(:post, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :title, :string
      add :body, :text
      add :description, :text
      add :published_at, :naive_datetime

      timestamps(type: :utc_datetime)
    end
  end
end
