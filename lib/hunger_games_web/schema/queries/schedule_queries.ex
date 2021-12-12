defmodule HungerGamesWeb.Schema.ScheduleQueries do
  use Absinthe.Schema.Notation

  alias HungerGamesWeb.Schema.ScheduleResolvers
  alias HungerGamesWeb.Schema.Middleware

  object :schedule_queries do
    @desc """
    Get schedule details
    """
    field :schedule, type: :schedule do
      arg(:id, :id)
      resolve(&ScheduleResolvers.get_schedule/3)
    end

    field :list_schedules, type: non_null(list_of(non_null(:schedule))) do
      middleware(Middleware.Authorization)
      resolve(&ScheduleResolvers.list_schedules/3)
    end
  end
end
