defmodule HungerGames.Repo do
  use Ecto.Repo,
    otp_app: :hunger_games,
    adapter: Ecto.Adapters.Postgres
end
