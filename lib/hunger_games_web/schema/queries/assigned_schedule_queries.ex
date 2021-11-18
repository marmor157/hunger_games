defmodule HungerGamesWeb.Schema.AssignedScheduleQueries do
  use Absinthe.Schema.Notation

  alias HungerGamesWeb.Schema.AssignedScheduleResolvers

  object :assigned_schedule_queries do
    @desc """
    Get assigned schedule details
    """
    field :assigned_schedule, type: :assigned_schedule do
      arg(:id, :id)
      resolve(&AssignedScheduleResolvers.get_assigned_schedule/3)
    end
  end
end
