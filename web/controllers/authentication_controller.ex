defmodule RideShare.AuthenticationController do
  use RideShare.Web, :controller

  alias RideShare.GoogleAuth

  def index(conn, _params) do
    redirect(conn,
      external:
        Google.authorize_url!(
          scope: "https://www.googleapis.com/auth/userinfo.email",
          redirect_uri: authentication_url(conn, :callback)
        )
    )
  end

  def callback(conn, %{"code" => code}) do
    {:ok, user} = GoogleAuth.handle_callback(code)

    conn
    |> put_session(:current_user, user)
    |> redirect(to: "/")
  end

  def delete(conn, _params) do
    conn
    |> put_flash(:info, "You have been logged out!")
    |> configure_session(drop: true)
    |> redirect(to: "/")
  end
end
