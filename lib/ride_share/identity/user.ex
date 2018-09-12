defmodule RideShare.Identity.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias RideShare.Identity.Credential

  @email_regex ~r/^(?<user>[^\s]+)@(?<domain>[^\s]+\.[^\s]+)$/

  schema "users" do
    has_many :credentials, Credential

    field(:email, :string)
    field(:given_name, :string)
    field(:family_name, :string)
    field(:avatar, :string)

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :given_name, :family_name, :avatar])
    |> validate_required([:email, :given_name, :family_name])
    |> validate_format(:email, @email_regex)
    |> unique_constraint(:email)
  end
end
