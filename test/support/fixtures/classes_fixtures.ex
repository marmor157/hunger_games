defmodule HungerGames.ClassesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `HungerGames.Classes` context.
  """

  @doc """
  Generate a class.
  """
  def class_fixture(attrs \\ %{}) do
    {:ok, class} =
      attrs
      |> Enum.into(%{
        name: "some name",
        rrule: "some rrule",
        size_limit: 42,
        type: "some type"
      })
      |> HungerGames.Classes.create_class()

    class
  end
end
