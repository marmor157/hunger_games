defmodule HungerGames.StudentsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `HungerGames.Students` context.
  """

  @doc """
  Generate a student.
  """
  def student_fixture(attrs \\ %{}) do
    {:ok, student} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> HungerGames.Students.create_student()

    student
  end
end
