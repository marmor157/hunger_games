defmodule HungerGamesWeb.Schema.ScheduleTypes do
  use Absinthe.Schema.Notation

  import Absinthe.Resolution.Helpers

  object :schedule do
    field :id, non_null(:id)
    field :name, non_null(:string)

    field :classes, non_null(list_of(non_null(:class))) do
      resolve(dataloader(:db))
    end
  end

  input_object :create_schedule_input do
    field :name, non_null(:string)
  end
end
