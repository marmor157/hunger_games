defmodule HungerGamesWeb.Schema.StudentResolvers do
  def get_student(_parent, _args, _ctx) do
    {:ok,
     %{
       name: "Random name",
       id: "random id",
       classes: []
     }}
  end
end
