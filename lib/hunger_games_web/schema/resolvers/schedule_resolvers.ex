defmodule HungerGamesWeb.Schema.ScheduleResolvers do
  alias HungerGames.Schedules

  def get_schedule(_parent, %{id: id}, _ctx) do
    {:ok, Schedules.get_schedule(id)}
  end

  def create_schedule(_parent, %{input: input}, _ctx) do
    Schedules.create_schedule(input)
  end
end
