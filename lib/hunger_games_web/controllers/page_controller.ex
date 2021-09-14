defmodule HungerGamesWeb.PageController do
  use HungerGamesWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
