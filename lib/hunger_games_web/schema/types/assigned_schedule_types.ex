defmodule HungerGamesWeb.Schema.AssignedScheduleTypes do
  use Absinthe.Schema.Notation

  import Absinthe.Resolution.Helpers

  object :assigned_schedule do
    field :id, non_null(:id)

    field :student, non_null(:student) do
      resolve(dataloader(:db))
    end

    field :schedule, non_null(:schedule) do
      resolve(dataloader(:db))
    end

    field :classes, non_null(list_of(non_null(:class))) do
      resolve(dataloader(:db))
    end
  end
end
