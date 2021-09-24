defmodule HungerGames.SchedulesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `HungerGames.Schedules` context.
  """

  @doc """
  Generate a schedule.
  """
  def schedule_fixture(attrs \\ %{}) do
    {:ok, schedule} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> HungerGames.Schedules.create_schedule()

    schedule
  end
end
