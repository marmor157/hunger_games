defmodule HungerGames.LecturersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `HungerGames.Lecturers` context.
  """

  @doc """
  Generate a lecturer.
  """
  def lecturer_fixture(attrs \\ %{}) do
    {:ok, lecturer} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> HungerGames.Lecturers.create_lecturer()

    lecturer
  end
end
