defmodule HungerGamesWeb.Schema.ClassRequestTypes do
  use Absinthe.Schema.Notation

  object :base_class_request do
    field :priority, non_null(:integer)
  end

  object :class_request do
    import_fields :base_class_request

    field :id, non_null(:id)
    field :request, non_null(:request)
    field :class, non_null(:class)
  end

  input_object :class_request_input do
    import_fields :base_class

    field :request_id, non_null(:id)
    field :class_id, non_null(:id)
  end
end
