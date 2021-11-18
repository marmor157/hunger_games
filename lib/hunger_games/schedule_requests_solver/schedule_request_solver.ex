defmodule HungerGames.ScheduleRequestSolver do
  alias HungerGames.{Schedules.Schedule, ScheduleRequestSolver.Class}

  @callback solve_schedule(schedule :: Schedule.t()) :: list(Class.t())
end
