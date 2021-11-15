defmodule HungerGames.AssignScheduleWorker do
  use Oban.Worker,
    queue: :schedule,
    priority: 1,
    max_attempts: 3

  alias Ecto.Multi

  alias HungerGames.{
    AssignedSchedules,
    SimpleScheduleRequestSolver,
    Schedules,
    Schedules.Schedule,
    Repo
  }

  @spec enqueue_schedule(HungerGames.Schedules.Schedule.t()) ::
          {:error, any} | {:ok, Oban.Job.t()}
  def enqueue_schedule(%Schedule{id: id, registration_end_date: date}) do
    %{id: id}
    |> HungerGames.AssignScheduleWorker.new(scheduled_at: date)
    |> Oban.insert()
  end

  @impl Oban.Worker
  def perform(%Oban.Job{args: %{"id" => id}}) do
    schedule =
      id
      |> Schedules.get_schedule()
      |> Repo.preload(requests: [class_requests: [:request, :class], student: []], classes: [])

    classes = SimpleScheduleRequestSolver.solve_schedule(schedule)
    students = schedule.requests |> Enum.map(& &1.student.id)

    assigned_schedules =
      students
      |> Enum.map(fn student_id ->
        %{
          student_id: student_id,
          schedule_id: id,
          classes:
            classes
            |> Enum.filter(&Enum.member?(&1.current_students, student_id))
            |> Enum.map(&%{id: &1.id})
        }
      end)

    Multi.new()
    |> Multi.run(:insert_assigned_schedules, fn _repo, _changes ->
      result =
        assigned_schedules
        |> Enum.map(&AssignedSchedules.create_assigned_schedule/1)

      case Enum.all?(result, &match?({:ok, _}, &1)) do
        true -> {:ok, result}
        false -> {:error, result}
      end
    end)
    |> Repo.transaction()
  end
end
