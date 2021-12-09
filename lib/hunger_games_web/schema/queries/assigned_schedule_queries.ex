defmodule HungerGamesWeb.Schema.AssignedScheduleQueries do
  use Absinthe.Schema.Notation

  alias HungerGamesWeb.Schema.AssignedScheduleResolvers
  alias HungerGamesWeb.Schema.Middleware

  object :assigned_schedule_queries do
    @desc """
    Get assigned schedule details
    """
    field :assigned_schedule, type: :assigned_schedule do
      arg(:id, :id)
      middleware(Middleware.Authorization)
      resolve(&AssignedScheduleResolvers.get_assigned_schedule/3)
    end

    @desc """
    Get assigned schedule details
    """
    field :assigned_schedule_by_schedule_id, type: :assigned_schedule do
      arg(:schedule_id, :id)
      middleware(Middleware.Authorization)
      resolve(&AssignedScheduleResolvers.get_assigned_schedule_by_student_schedule/3)
    end

    @desc """
    Lists user's assigned schedules
    """
    field :list_assigned_schedules, type: non_null(list_of(non_null(:assigned_schedule))) do
      middleware(Middleware.Authorization)
      resolve(&AssignedScheduleResolvers.list_assigned_schedules/3)
    end
  end
end
