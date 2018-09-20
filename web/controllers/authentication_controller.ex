defmodule RideShare.AuthenticationController do
  use RideShare.Web, :controller

  defconstp :google, RideShare.GoogleAuth

  def index(conn, _params) do
    callback_url = authentication_url(conn, :callback)
    authorization_url = google.authorization_url(redirect_to: callback_url)

    redirect(conn, external: authorization_url)
  end

  def callback(conn, %{"code" => code}) do
    {:ok, user} = google.handle_callback(code)

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
