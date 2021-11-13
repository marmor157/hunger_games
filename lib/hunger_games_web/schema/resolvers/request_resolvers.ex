defmodule HungerGamesWeb.Schema.RequestResolvers do
  alias HungerGames.Requests

  def get_request(_parent, %{id: id}, _ctx) do
    {:ok, Requests.get_request(id)}
  end

  def create_request(_parent, %{input: input}, _ctx) do
    input
    |> Map.put(
      :date,
      DateTime.now("Etc/UTC")
      |> elem(1)
    )
    |> Requests.create_request()
  end
end
