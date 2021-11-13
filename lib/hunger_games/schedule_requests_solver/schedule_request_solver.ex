defmodule HungerGames.ScheduleRequestSolver do
  alias HungerGames.{Schedules.Schedule}

  @type class :: %{
          id: Ecto.UUID.t(),
          rrule: String.t(),
          size_limit: integer(),
          current_students: list(Ecto.UUID.t()),
          name: String.t(),
          type: atom()
        }

  @callback solve_schedule(schedule :: Schedule.t()) :: list(class())
end
