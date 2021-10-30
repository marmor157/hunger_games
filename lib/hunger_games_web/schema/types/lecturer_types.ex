defmodule HungerGamesWeb.Schema.LecturerTypes do
  use Absinthe.Schema.Notation

  object :base_lecturer do
    field :name, non_null(:string)
  end

  object :lecturer do
    import_fields :base_lecturer

    field :id, non_null(:id)

    field :classes, non_null(list_of(non_null(:class))) do
      resolve(:db)
    end
  end

  input_object :create_lecturer_input do
    import_fields :base_lecturer
  end
end
