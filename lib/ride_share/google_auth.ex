defmodule RideShare.GoogleAuth do
  alias RideShare.Accounts

  import Dependency

  defconstp :google, Google

  def authorization_url(redirect_to: redirect_url) do
    google.authorize_url!(
      scope: "https://www.googleapis.com/auth/userinfo.email",
      redirect_uri: redirect_url
    )
  end

  def handle_callback(code) do
    {data, access_token} = extract_access_info(code)

    verify(data, access_token)
  end

  defp extract_access_info(code) do
    client = Google.get_token!(code: code)

    %{body: data} =
      OAuth2.Client.get!(client, "https://www.googleapis.com/plus/v1/people/me/openIdConnect")

    {data, client.token.access_token}
  end

  defp verify(data = %{"email" => email}, access_token) do
    case Accounts.get_user_by(email: email) do
      nil ->
        register_user(data, access_token)

      existing ->
        {:ok, existing}
    end
  end

  defp register_user(data, access_token) do
    Accounts.register_user(%{
      email: data["email"],
      given_name: data["given_name"],
      family_name: data["family_name"],
      avatar: data["picture"],
      credentials: [
        %{
          type: "google",
          token: access_token
        }
      ]
    })
  end
end
