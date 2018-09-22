defmodule RideShare.GoogleAuthTest do
  use RideShare.ModelCase

  alias RideShare.GoogleAuth

  defmodule FakeGoogle do
    def authorize_url!(opts) do
      assert Keyword.get(opts, :redirect_uri) == "/return-url"

      "http://auth.google.com/abcd"
    end
  end

  setup do
    Dependency.register(Google, FakeGoogle)

    :ok
  end

  test "authorization_url builds url" do
    assert GoogleAuth.authorization_url(redirect_to: "/return-url") == "http://auth.google.com/abcd"
  end
end
