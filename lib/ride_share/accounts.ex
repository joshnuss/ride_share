defmodule RideShare.Accounts do
  alias RideShare.Repo
  alias RideShare.Accounts.User

  def get_user_by(filters) do
    Repo.get_by(User, filters)
  end

  def register_user(user) do
    user
    |> User.new()
    |> Repo.insert()
  end
end
