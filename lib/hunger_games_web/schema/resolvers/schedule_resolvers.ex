defmodule HungerGamesWeb.Schema.ScheduleResolvers do
  alias HungerGames.Schedules

  def get_schedule(_parent, %{id: id}, _ctx) do
    {:ok, Schedules.get_schedule(id)}
  end

  def create_schedule(_parent, %{input: input}, %{context: %{current_user: user}}) do
    with :gt <- DateTime.compare(input.registration_end_date, DateTime.utc_now()),
         input <- Map.put(input, :creator_id, user.id),
         {:ok, schedule} <- Schedules.create_schedule(input) do
      {:ok, schedule}
    else
      :lt -> {:error, "Date must be greater than now"}
      error -> error
    end
  end

  def list_schedules(_parent, _args, %{context: %{current_user: user}}) do
    {:ok, Schedules.list_schedules_by_creator(user.id)}
  end
end
