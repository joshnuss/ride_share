defmodule RideShare.Repo.Migrations.AddInitialSchema do
  use Ecto.Migration

  def change do
    create table(:users) do
      add(:email, :string, null: false)
      add(:given_name, :string, null: false)
      add(:family_name, :string, null: false)
      add(:avatar, :string)
      add(:vehicle, :json)

      timestamps()
    end

    unique_index(:users, :email) |> create

    create table(:credentials) do
      add(:user_id, references(:users))
      add(:type, :string, null: false)
      add(:token, :string, null: false)

      timestamps()
    end

    index(:credentials, [:user_id, :type]) |> create
  end
end
