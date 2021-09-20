defmodule HungerGamesWeb.Schema.ScheduleTypes do
  use Absinthe.Schema.Notation

  import Absinthe.Resolution.Helpers

  object :schedule do
    field :id, non_null(:id)
    field :name, non_null(:string)

    field :subjects, non_null(list_of(non_null(:subject))) do
      resolve(dataloader(:db))
    end
  end

  input_object :schedule_input do
    field :name, non_null(:string)
    field :subjects, non_null(list_of(non_null(:subject_input)))
  end
end
