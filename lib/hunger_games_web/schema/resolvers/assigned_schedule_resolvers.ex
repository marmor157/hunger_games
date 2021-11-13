defmodule HungerGamesWeb.Schema.AssignedScheduleResolvers do
  alias HungerGames.AssignedSchedules

  def get_assigned_schedule(_parent, %{id: id}, _ctx) do
    {:ok, AssignedSchedules.get_assigned_schedule(id)}
  end
end
