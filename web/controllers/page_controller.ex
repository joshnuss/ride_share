defmodule RideShare.PageController do
  use RideShare.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
