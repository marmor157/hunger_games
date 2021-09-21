defmodule HungerGamesWeb.Schema.StudentTypes do
  use Absinthe.Schema.Notation

  import Absinthe.Resolution.Helpers

  object :base_student do
    field :name, non_null(:string)
  end

  object :student do
    import_fields :base_student
    field :id, non_null(:id)

    field :classes, non_null(list_of(non_null(:class))) do
      resolve(dataloader(:db))
    end
  end

  input_object :student_input do
    import_fields :base_student
  end
end
