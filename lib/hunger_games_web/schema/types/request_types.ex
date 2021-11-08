defmodule HungerGamesWeb.Schema.RequestTypes do
  use Absinthe.Schema.Notation

  import Absinthe.Resolution.Helpers

  object :request do
    field :id, non_null(:id)
    field :date, non_null(:date)

    field :student, non_null(:student)
    field :schedule, non_null(:schedule)

    field :classes, non_null(list_of(non_null(:class))) do
      resolve(dataloader(:db))
    end

    field :class_requests, non_null(list_of(non_null(:class_request))) do
      resolve(dataloader(:db))
    end
  end

  input_object :request_input do
    field :student_id, non_null(:id)
    field :schedule_id, non_null(:id)

    field :classes, non_null(list_of(non_null(:class_request_input)))
  end
end
