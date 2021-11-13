defmodule HungerGames.Factory do
  use ExMachina.Ecto, repo: HungerGames.Repo

  alias HungerGames.{
    AssignedSchedules,
    ClassRequests,
    Classes,
    Lecturers,
    Requests,
    Schedules,
    Students
  }

  alias AssignedSchedules.AssignedSchedule
  alias ClassRequests.ClassRequest
  alias Classes.Class
  alias Lecturers.Lecturer
  alias Requests.Request
  alias Schedules.Schedule
  alias Students.Student

  # Factories
  def assigned_schedule_factory(attrs) do
    assigned_schedule = %AssignedSchedule{
      classes: []
    }

    merge_attributes(assigned_schedule, attrs)
  end

  def class_request_factory(attrs) do
    class_request = %ClassRequest{
      priority: Enum.random(1..3)
    }

    merge_attributes(class_request, attrs)
  end

  def class_factory(attrs) do
    class = %Class{
      name: sequence("name"),
      rrule: "RRULE:FREQ=DAILY;INTERVAL=1",
      size_limit: Enum.random(1..25),
      type: :exercises
    }

    merge_attributes(class, attrs)
  end

  def lecturer_factory(attrs) do
    lecturer = %Lecturer{
      name: sequence("name")
    }

    merge_attributes(lecturer, attrs)
  end

  def request_factory(attrs) do
    request = %Request{
      date: ~U[2021-10-31 15:10:00.000000Z]
    }

    merge_attributes(request, attrs)
  end

  def schedule_factory(attrs) do
    schedule = %Schedule{
      name: sequence("name")
    }

    merge_attributes(schedule, attrs)
  end

  def student_factory(attrs) do
    student = %Student{
      name: sequence("name")
    }

    merge_attributes(student, attrs)
  end
end
