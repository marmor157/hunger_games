defmodule HungerGamesWeb.Schema.ScheduleTypes do
  use Absinthe.Schema.Notation

  import Absinthe.Resolution.Helpers

  object :schedule_base do
    field :name, non_null(:string)
    field :registration_end_date, non_null(:datetime)
  end

  object :schedule do
    import_fields(:schedule_base)
    field :id, non_null(:id)

    field :classes, non_null(list_of(non_null(:class))) do
      resolve(dataloader(:db))
    end

    field :requests, non_null(list_of(non_null(:request))) do
      resolve(dataloader(:db))
    end

    field :assigned_schedules, non_null(list_of(non_null(:assigned_schedule))) do
      resolve(dataloader(:db))
    end
  end

  input_object :create_schedule_input do
    import_fields(:schedule_base)
  end
end
