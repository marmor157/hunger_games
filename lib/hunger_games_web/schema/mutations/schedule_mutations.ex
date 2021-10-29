defmodule HungerGamesWeb.Schema.ScheduleMutations do
  use Absinthe.Schema.Notation

  alias HungerGamesWeb.Schema.ScheduleResolvers

  object :schedule_mutations_root do
    @desc """
    Creates schedule entity
    """
    field :schedule_create, non_null(:schedule) do
      arg(:input, :create_schedule_input)
      resolve(&ScheduleResolvers.create_schedule/3)
    end
  end
end
