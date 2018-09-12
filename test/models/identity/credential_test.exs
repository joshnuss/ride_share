defmodule RideShare.Identity.CredentialTest do
  use RideShare.ModelCase

  alias RideShare.Identity.Credential

  @valid_attrs %{user_id: 1, type: "google", token: "abcd123"}

  test "changeset with valid attributes" do
    changeset = Credential.changeset(%Credential{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset without user_id is invalid" do
    changeset = Credential.changeset(%Credential{}, %{user_id: nil})

    refute changeset.valid?
    assert changeset.errors[:user_id]
  end

  test "changeset without type is invalid" do
    changeset = Credential.changeset(%Credential{}, %{type: ""})

    refute changeset.valid?
    assert changeset.errors[:type]
  end

  test "changeset with unknown type is invalid" do
    changeset = Credential.changeset(%Credential{}, %{type: "foobar"})

    refute changeset.valid?
    assert changeset.errors[:type]
  end

  test "changeset without token is invalid" do
    changeset = Credential.changeset(%Credential{}, %{token: ""})

    refute changeset.valid?
    assert changeset.errors[:token]
  end
end
