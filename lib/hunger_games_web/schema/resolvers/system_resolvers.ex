defmodule HungerGamesWeb.Schema.SystemResolvers do
  def get_system_status(_parent, _args, _ctx) do
    {:ok,
     %{
       status: "ok",
       version: Application.spec(:hunger_games, :vsn)
     }}
  end
end
