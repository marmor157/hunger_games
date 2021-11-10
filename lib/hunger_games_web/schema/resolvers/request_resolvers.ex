defmodule HungerGamesWeb.Schema.RequestResolvers do
  alias HungerGames.Requests

  def get_request(_parent, %{id: id}, _ctx) do
    {:ok, Requests.get_request(id)}
  end

  def create_request(_parent, %{input: input}, _ctx) do
    Requests.create_request(input)
  end
end
