defmodule HungerGamesWeb.Schema.ScheduleResolvers do
  alias HungerGames.Schedules

  def get_schedule(_parent, %{id: id}, _ctx) do
    {:ok, Schedules.get_schedule(id)}
  end

  def create_schedule(_parent, %{input: input}, %{context: %{current_user: user}}) do
    with true <- Date.diff(input.registration_end_date, Date.utc_today()) > 0,
         input <- Map.put(input, :creator_id, user.id),
         {:ok, schedule} <- Schedules.create_schedule(input) do
      {:ok, schedule}
    else
      false -> {:error, "Date must be greater than now"}
      error -> error
    end
  end
end
