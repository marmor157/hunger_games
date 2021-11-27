defmodule HungerGamesWeb.Schema.LecturerResolvers do
  alias HungerGames.Lecturers

  def get_lecturer(_parent, %{id: id}, _ctx) do
    {:ok, Lecturers.get_lecturer(id)}
  end

  def list_lecturers(_parent, _args, _ctx) do
    {:ok, Lecturers.list_lecturers()}
  end

  def create_lecturer(_parent, %{input: input}, _ctx) do
    Lecturers.create_lecturer(input)
  end
end
