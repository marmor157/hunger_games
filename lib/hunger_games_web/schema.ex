defmodule HungerGamesWeb.Schema do
  use Absinthe.Schema

  alias HungerGamesWeb.Schema

  # Scalars
  import_types(Schema.RRuleTypes)

  # Types
  import_types(Absinthe.Type.Custom)

  import_types(Schema.ClassTypes)
  import_types(Schema.LecturerTypes)
  import_types(Schema.ScheduleTypes)
  import_types(Schema.StudentTypes)
  import_types(Schema.SystemTypes)

  # Queries

  import_types(Schema.ClassQueries)
  import_types(Schema.LecturerQueries)
  import_types(Schema.ScheduleQueries)
  import_types(Schema.StudentQueries)
  import_types(Schema.SystemQueries)

  # Mutations
  import_types(Schema.ScheduleMutations)

  query do
    import_fields(:class_queries)
    import_fields(:lecturer_queries)
    import_fields(:schedule_queries)
    import_fields(:student_queries)
    import_fields(:system_queries)
  end

  mutation do
    import_fields(:schedule_mutations_root)
  end

  def context(ctx) do
    Map.put(ctx, :loader, HungerGamesWeb.Dataloader.loader())
  end

  def plugins do
    [Absinthe.Middleware.Dataloader | Absinthe.Plugin.defaults()]
  end
end
