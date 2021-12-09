defmodule HungerGamesWeb.Schema.AssignedScheduleResolvers do
  alias HungerGames.AssignedSchedules
  alias AssignedSchedules.AssignedSchedule

  def get_assigned_schedule(_parent, %{id: id}, %{context: %{current_user: user}}) do
    with %AssignedSchedule{} = schedule <- AssignedSchedules.get_assigned_schedule(id),
         true <- schedule.student_id == user.id do
      {:ok, schedule}
    else
      nil -> {:error, :not_found}
      false -> {:error, :not_authorized}
    end
  end

  def get_assigned_schedule_by_student_schedule(
        _parent,
        %{schedule_id: schedule_id},
        %{context: %{current_user: user}}
      ) do
    {:ok, AssignedSchedules.get_assigned_schedule_by_student_schedule(user.id, schedule_id)}
  end

  def list_assigned_schedules(_parent, _args, %{context: %{current_user: user}}) do
    {:ok, AssignedSchedules.list_assigned_schedules_by_student_id(user.id)}
  end
end
