defmodule HungerGamesWeb.Schema.RequestResolvers do
  alias HungerGames.{Requests, Schedules, Schedules.Schedule}

  def get_request(_parent, %{id: id}, _ctx) do
    {:ok, Requests.get_request(id)}
  end

  def create_request(_parent, %{input: input}, %{context: %{current_user: user}}) do
    date_now = DateTime.utc_now()

    with %Schedule{registration_start_date: start_date, registration_end_date: end_date} <-
           Schedules.get_schedule(input.schedule_id),
         :lt <- DateTime.compare(start_date, date_now),
         :gt <- DateTime.compare(end_date, date_now) do
      input
      |> Map.put(:date, date_now)
      |> Map.put(:student_id, user.id)
      |> Requests.create_request()
    else
      nil ->
        {:error, "No such schedule"}

      _ ->
        {:error, "Registration closed"}
    end
  end
end
