defmodule HungerGamesWeb.Schema.StudentResolvers do
  def get_student(_parent, _args, _ctx) do
    {:ok, HungerGames.Students.get_student(1)}
  end
end
