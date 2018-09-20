defmodule RideShare.AccountsTest do
  use RideShare.ModelCase

  alias RideShare.Accounts

  test "register_user/1 creates a user" do
    {:ok, user} = Accounts.register_user(%{
      email: "user@example.com",
      given_name: "John",
      family_name: "Smith"
    })

    assert user == Accounts.get_user_by(email: "user@example.com")
  end

  test "get_user_by/1 returns nil when it's missing" do
    refute Accounts.get_user_by(email: "user@example.com")
  end
end
