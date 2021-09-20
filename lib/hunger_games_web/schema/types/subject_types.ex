defmodule HungerGamesWeb.Schema.SubjectTypes do
  use Absinthe.Schema.Notation

  import Absinthe.Resolution.Helpers

  enum :subject_type do
    value(:lecture)
    value(:exercises)
    value(:laboratories)
    value(:computer_laboratories)
    value(:project)
  end

  object :subject do
    field :id, non_null(:id)
    field :name, non_null(:id)
    field :type, non_null(:subject_type)
    field :rrule, non_null(:rrule)
  end

  input_object :subject_input do
    field :name, non_null(:id)
    field :type, non_null(:subject_type_input)
    field :rrule, non_null(:rrule)
  end
end
