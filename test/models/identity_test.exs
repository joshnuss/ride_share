defmodule RideShare.IdentityTest do
  use RideShare.ModelCase

  alias RideShare.Identity

  test "register/1 creates a user" do
    {:ok, _} = Identity.register_user(%{
      email: "user@example.com",
      given_name: "John",
      family_name: "Smith"
    })

    assert Identity.get_user_by(email: "user@example.com")
  end

  test "get_user_by/1 returns nil when it's missing" do
    refute Identity.get_user_by(email: "user@example.com")
  end
end
