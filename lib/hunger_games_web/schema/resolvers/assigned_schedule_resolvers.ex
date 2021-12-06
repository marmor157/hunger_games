defmodule HungerGamesWeb.Schema.AssignedScheduleResolvers do
  alias HungerGames.AssignedSchedules

  def get_assigned_schedule(_parent, %{id: id}, _ctx) do
    {:ok, AssignedSchedules.get_assigned_schedule(id)}
  end

  def get_assigned_schedule_by_student_schedule(
        _parent,
        %{student_id: student_id, schedule_id: schedule_id},
        _ctx
      ) do
    {:ok, AssignedSchedules.get_assigned_schedule_by_student_schedule(student_id, schedule_id)}
  end
end
