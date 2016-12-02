defmodule ChatExample.SessionController do
  use ChatExample.Web, :controller

  def new(conn, _params) do
    render conn, "new.html", current_user: nil
  end

  def create(conn, %{"session" => %{"user_name" => user_name}}) do
    if String.length(user_name) > 0 do
      conn
      |> put_flash(:info, "Willkommen, #{user_name}!")
      |> put_session(:current_user, user_name)
      |> redirect(to: "/")
    else
      conn
      |> put_flash(:error, "Bitte einen Namen angeben")
      |> render("new.html", current_user: nil)
    end
  end

  def delete(conn, _params) do
    conn
    |> clear_session
    |> put_flash(:info, "Auf Wiedersehen")
    |> redirect(to: "/")
  end
end
