defmodule ChatExample.PageController do
  use ChatExample.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
