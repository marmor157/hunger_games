defmodule HungerGamesWeb.Schema.RequestTypes do
  use Absinthe.Schema.Notation

  import Absinthe.Resolution.Helpers

  object :request do
    field :id, non_null(:id)
    field :date, non_null(:datetime)

    field :student, non_null(:student) do
      resolve(dataloader(:db))
    end

    field :schedule, non_null(:schedule) do
      resolve(dataloader(:db))
    end

    field :classes, non_null(list_of(non_null(:class))) do
      resolve(dataloader(:db))
    end

    field :class_requests, non_null(list_of(non_null(:class_request))) do
      resolve(dataloader(:db))
    end
  end

  input_object :create_request_input do
    field :schedule_id, non_null(:id)

    field :classes, non_null(list_of(non_null(:class_request_input)))
  end
end
