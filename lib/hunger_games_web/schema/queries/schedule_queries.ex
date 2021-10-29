defmodule HungerGamesWeb.Schema.ScheduleQueries do
  use Absinthe.Schema.Notation

  alias HungerGamesWeb.Schema.ScheduleResolvers

  object :schedule_queries do
    @desc """
    Get schedule details
    """
    field :schedule, type: :schedule do
      arg(:id, :id)
      resolve(&ScheduleResolvers.get_schedule/3)
    end
  end
end
