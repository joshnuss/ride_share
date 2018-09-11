defmodule RideShare.Repo.Migrations.AddInitialSchema do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string, null: false
      add :first_name, :string, null: false
      add :last_name, :string, null: false
      add :vehicle, :json

      timestamps()
    end

    create unique_index(:users, :email)

    create table(:credentials) do
      add :user_id, references(:users)
      add :type, :string, null: false
      add :token, :string, null: false

      timestamps()
    end

    create index(:credentials, [:user_id, :type])
  end
end
