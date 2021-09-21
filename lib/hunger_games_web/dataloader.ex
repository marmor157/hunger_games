defmodule HungerGamesWeb.Dataloader do
  import Ecto.Query, warn: false

  alias HungerGames.Repo
  alias Dataloader

  def loader() do
    Dataloader.new() |> Dataloader.add_source(:db, data())
  end

  defp data() do
    Dataloader.Ecto.new(Repo, query: &query/2)
  end

  defp query(queryable, _) do
    queryable
  end
end
