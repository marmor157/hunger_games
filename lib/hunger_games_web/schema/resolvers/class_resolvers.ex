defmodule HungerGamesWeb.Schema.ClassResolvers do
  alias HungerGames.Classes

  def get_class(_parent, %{id: id}, _ctx) do
    {:ok, Classes.get_class(id)}
  end

  def create_class(_parent, %{input: input}, _ctx) do
    Classes.create_class(input)
  end
end
