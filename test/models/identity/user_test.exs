defmodule RideShare.Identity.UserTest do
  use RideShare.ModelCase

  alias RideShare.Identity.User

  @valid_attrs %{email: "user@example.com", first_name: "John", last_name: "Smith"}

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

  test "changeset without first_name is invalid" do
    changeset = User.changeset(%User{}, %{first_name: ""})

    refute changeset.valid?
    assert changeset.errors[:first_name]
  end

  test "changeset without last_name is invalid" do
    changeset = User.changeset(%User{}, %{last_name: ""})

    refute changeset.valid?
    assert changeset.errors[:last_name]
  end

  test "changeset without duplicate email is invalid" do
    insert_user(@valid_attrs)
    {:error, changeset} = insert_user(@valid_attrs)

    refute changeset.valid?
    assert changeset.errors[:email]
  end

  defp insert_user(attributes) do
    %User{}
    |> User.changeset(@valid_attrs)
    |> Repo.insert()
  end
end
