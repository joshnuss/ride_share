defmodule RideShare.GoogleAuth do
  alias RideShare.Identity

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
    case Identity.get_user_by(email: email) do
      nil ->
        register_user(data, access_token)

      existing ->
        {:ok, existing}
    end
  end

  defp register_user(data, access_token) do
    Identity.register_user(%{
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
