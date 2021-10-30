defmodule HungerGamesWeb.Schema.StudentResolvers do
  alias HungerGames.Students

  def get_student(_parent, %{id: id}, _ctx) do
    {:ok, Students.get_student(id)}
  end

  def create_student(_parent, %{input: input}, _ctx) do
    Students.create_student(input)
  end
end
