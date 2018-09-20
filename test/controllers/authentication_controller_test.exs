defmodule RideShare.AuthenticationControllerTest do
  use RideShare.ConnCase

  defmodule FakeAuth do
    def authorization_url(redirect_to: redirect_url) do
      assert redirect_url =~ ~r{auth/callback}

      "https://auth.google.com"
    end

    def handle_callback("public-code") do
      {:ok, :fake_user}
    end
  end

  setup do
    Dependency.register RideShare.GoogleAuth, FakeAuth

    :ok
  end

  test "GET /auth", %{conn: conn} do
    conn = get(conn, authentication_path(conn, :index))

    assert redirected_to(conn, 302) == "https://auth.google.com"
  end

  test "GET /callback", %{conn: conn} do
    conn = get(conn, authentication_path(conn, :callback, %{"code" => "public-code"}))

    assert redirected_to(conn, 302) == "/"
    assert get_session(conn, :current_user) == :fake_user
  end

  test "DELETE /auth", %{conn: conn} do
    conn = delete(conn, authentication_path(conn, :delete))

    assert redirected_to(conn, 302) == "/"
    assert get_flash(conn, :info) =~ "logged out"
    refute get_session(conn, :current_user)
  end
end
