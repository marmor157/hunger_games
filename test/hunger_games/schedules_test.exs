defmodule HungerGames.SchedulesTest do
  use HungerGames.DataCase
  use Oban.Testing, repo: HungerGames.Repo

  alias HungerGames.Schedules

  import HungerGames.Factory

  describe "schedules" do
    alias HungerGames.Schedules.Schedule

    @valid_attrs %{
      name: "some name",
      registration_end_date: ~U[2021-10-31 15:10:00.000000Z],
      registration_start_date: ~U[2021-10-31 14:10:00.000000Z],
      start_date: ~D[2021-11-01],
      end_date: ~D[2021-12-01]
    }
    @invalid_attrs %{name: nil}

    setup do
      student = insert(:student)

      [creator_id: student.id, creator: student]
    end

    def schedule_fixture(attrs \\ %{}) do
      {:ok, schedule} =
        attrs
        |> Enum.into(@valid_attrs)
        |> HungerGames.Schedules.create_schedule()

      schedule
    end

    test "list_schedules/0 returns all schedules", ctx do
      schedule = schedule_fixture(ctx)
      assert Schedules.list_schedules() == [schedule]
    end

    test "get_schedule!/1 returns the schedule with given id", ctx do
      schedule = schedule_fixture(ctx)
      assert Schedules.get_schedule!(schedule.id) == schedule
    end

    test "create_schedule/1 with valid data creates a schedule", ctx do
      assert {:ok, %Schedule{} = schedule} =
               @valid_attrs |> Map.put(:creator_id, ctx.creator_id) |> Schedules.create_schedule()

      assert schedule.name == @valid_attrs.name
      assert schedule.registration_end_date == @valid_attrs.registration_end_date
      assert schedule.registration_start_date == @valid_attrs.registration_start_date
      assert schedule.start_date == @valid_attrs.start_date
      assert schedule.end_date == @valid_attrs.end_date

      assert_enqueued(
        worker: HungerGames.AssignScheduleWorker,
        args: %{id: schedule.id},
        scheduled_at: {schedule.registration_end_date, delta: 0}
      )
    end

    test "create_schedule/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Schedules.create_schedule(@invalid_attrs)
    end

    test "update_schedule/2 with valid data updates the schedule", ctx do
      schedule = schedule_fixture(ctx)
      update_attrs = %{name: "some updated name"}

      assert {:ok, %Schedule{} = schedule} = Schedules.update_schedule(schedule, update_attrs)
      assert schedule.name == "some updated name"
    end

    test "update_schedule/2 with invalid data returns error changeset", ctx do
      schedule = schedule_fixture(ctx)
      assert {:error, %Ecto.Changeset{}} = Schedules.update_schedule(schedule, @invalid_attrs)
      assert schedule == Schedules.get_schedule!(schedule.id)
    end

    test "delete_schedule/1 deletes the schedule", ctx do
      schedule = schedule_fixture(ctx)
      assert {:ok, %Schedule{}} = Schedules.delete_schedule(schedule)
      assert_raise Ecto.NoResultsError, fn -> Schedules.get_schedule!(schedule.id) end
    end

    test "change_schedule/1 returns a schedule changeset", ctx do
      schedule = schedule_fixture(ctx)
      assert %Ecto.Changeset{} = Schedules.change_schedule(schedule)
    end
  end
end
