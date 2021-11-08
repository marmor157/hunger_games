defmodule HungerGamesWeb.Schema.StudentTypes do
  use Absinthe.Schema.Notation

  import Absinthe.Resolution.Helpers

  object :base_student do
    field :name, non_null(:string)
  end

  object :student do
    import_fields :base_student
    field :id, non_null(:id)

    field :requests, non_null(list_of(non_null(:request))) do
      resolve(dataloader(:db))
    end

    field :assigned_schedules, non_null(list_of(non_null(:assigned_schedule))) do
      resolve(dataloader(:db))
    end
  end

  input_object :create_student_input do
    import_fields :base_student
  end
end
