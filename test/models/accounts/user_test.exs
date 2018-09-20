defmodule RideShare.Accounts.UserTest do
  use RideShare.ModelCase

  alias RideShare.Accounts.User

  @valid_attrs %{email: "user@example.com", given_name: "John", family_name: "Smith"}

  test "changeset with valid attributes" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset without email is invalid" do
    changeset = User.changeset(%User{}, %{email: ""})

    refute changeset.valid?
    assert changeset.errors[:email]
  end

  test "changeset with invalid email is invalid" do
    changeset = User.changeset(%User{}, %{email: "foobar"})

    refute changeset.valid?
    assert changeset.errors[:email]
  end

  test "changeset without given_name is invalid" do
    changeset = User.changeset(%User{}, %{given_name: ""})

    refute changeset.valid?
    assert changeset.errors[:given_name]
  end

  test "changeset without family_name is invalid" do
    changeset = User.changeset(%User{}, %{family_name: ""})

    refute changeset.valid?
    assert changeset.errors[:family_name]
  end

  test "changeset without duplicate email is invalid" do
    insert_user(@valid_attrs)
    {:error, changeset} = insert_user(@valid_attrs)

    refute changeset.valid?
    assert changeset.errors[:email]
  end

  defp insert_user(attributes) do
    attributes
    |> User.new()
    |> Repo.insert()
  end
end
