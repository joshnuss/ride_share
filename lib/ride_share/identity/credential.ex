defmodule RideShare.Identity.Credential do
  use Ecto.Schema
  import Ecto.Changeset

  alias RideShare.Identity.User

  schema "credentials" do
    belongs_to :user, User

    field(:type, :string)
    field(:token, :string)

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:user_id, :type, :token])
    |> validate_required([:user_id, :type, :token])
    |> validate_inclusion(:type, ["google"])
  end
end
