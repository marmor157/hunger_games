defmodule HungerGames.ScheduleRequestSolver.Class do
  @enforce_keys [:id, :rrule, :size_limit, :name, :type]
  defstruct id: "",
            rrule: "",
            size_limit: 0,
            current_students: [],
            name: "",
            type: :exercises

  @type t :: %__MODULE__{
          id: Ecto.UUID.t(),
          rrule: String.t(),
          size_limit: integer(),
          current_students: list(Ecto.UUID.t()),
          name: String.t(),
          type: atom()
        }
end
