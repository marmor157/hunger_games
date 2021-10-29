defmodule HungerGamesWeb.Schema.LecturerResolvers do
  alias HungerGames.Lecturers

  def get_lecturer(_parent, %{id: id}, _ctx) do
    {:ok, Lecturers.get_lecturer(id)}
  end
end
