defmodule RideShare.Identity.User do
  use Ecto.Schema
  import Ecto.Changeset

  @email_regex ~r/^(?<user>[^\s]+)@(?<domain>[^\s]+\.[^\s]+)$/

  schema "users" do
    field(:email, :string)
    field(:first_name, :string)
    field(:last_name, :string)
    field(:avatar, :string)

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :first_name, :last_name, :avatar])
    |> validate_required([:email, :first_name, :last_name])
    |> validate_format(:email, @email_regex)
    |> unique_constraint(:email)
  end
end
