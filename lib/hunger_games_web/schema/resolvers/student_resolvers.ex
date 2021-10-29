defmodule HungerGamesWeb.Schema.StudentResolvers do
  alias HungerGames.Students

  def get_student(_parent, %{id: id}, _ctx) do
    {:ok, Students.get_student(id)}
  end
end
