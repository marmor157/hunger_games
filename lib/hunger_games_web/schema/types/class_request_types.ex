defmodule HungerGamesWeb.Schema.ClassRequestTypes do
  use Absinthe.Schema.Notation

  import Absinthe.Resolution.Helpers

  object :base_class_request do
    field :priority, non_null(:integer)
  end

  object :class_request do
    import_fields :base_class_request

    field :id, non_null(:id)

    field :request, non_null(:request) do
      resolve(dataloader(:db))
    end

    field :class, non_null(:class) do
      resolve(dataloader(:db))
    end
  end

  input_object :class_request_input do
    import_fields :base_class_request

    field :class_id, non_null(:id)
  end
end
