defmodule HungerGamesWeb.Schema.ClassResolvers do
  alias HungerGames.{Classes, Classes.Class, Schedules, Schedules.Schedule}

  def get_class(_parent, %{id: id}, _ctx) do
    {:ok, Classes.get_class(id)}
  end

  def create_class(_parent, %{input: input}, %{context: %{current_user: user}}) do
    with %Schedule{} = schedule <- Schedules.get_schedule(input.schedule_id),
         true <- schedule.creator_id == user.id,
         :gt <- DateTime.compare(DateTime.utc_now(), schedule.registration_start_date) do
      Classes.create_class(input)
    end
  end

  def delete_class(_parent, %{id: id}, %{context: %{current_user: user}}) do
    with %Class{} = class <- Classes.get_class(id),
         %Schedule{} = schedule <- Schedules.get_schedule(class.schedule_id),
         true <- schedule.creator_id == user.id,
         :gt <- DateTime.compare(DateTime.utc_now(), schedule.registration_start_date) do
      Classes.delete_class(class)
    end
  end
end
