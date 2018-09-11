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
  end
end
