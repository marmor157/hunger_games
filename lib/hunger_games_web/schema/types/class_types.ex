defmodule HungerGamesWeb.Schema.ClassTypes do
  use Absinthe.Schema.Notation

  import Absinthe.Resolution.Helpers

  enum :class_type do
    value :lecture
    value :exercises
    value :laboratories
    value :computer_laboratories
    value :project
  end

  object :base_class do
    field :name, non_null(:string)
    field :type, non_null(:class_type)
    field :size_limit, non_null(:integer)
    field :rrule, non_null(:rrule)
  end

  object :class do
    import_fields :base_class

    field :id, non_null(:id)
    field :lecturer, non_null(:lecturer)
    field :schedule, non_null(:schedule)

    field :students, non_null(list_of(non_null(:student))) do
      resolve(dataloader(:db))
    end

    field :requests, non_null(list_of(non_null(:request))) do
      resolve(dataloader(:db))
    end

    field :class_requests, non_null(list_of(non_null(:class_request))) do
      resolve(dataloader(:db))
    end

    field :assigned_schedules, non_null(list_of(non_null(:assigned_schedule))) do
      resolve(dataloader(:db))
    end
  end

  input_object :create_class_input do
    import_fields :base_class

    field :lecturer_id, non_null(:id)
  end
end
