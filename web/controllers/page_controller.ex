defmodule ChatExample.PageController do
  use ChatExample.Web, :controller

  plug :authenticate

  def index(conn, _params) do
    render conn, "index.html"
  end

  defp authenticate(conn, _) do
    if current_user = get_session(conn, :current_user) do
      conn
      |> assign(:current_user, current_user)
    else
      conn
      |> redirect(to: session_path(conn, :new))
      |> halt
    end
  end
end
