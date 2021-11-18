defmodule HungerGames.SchedulesTest do
  use HungerGames.DataCase
  use Oban.Testing, repo: HungerGames.Repo

  alias HungerGames.Schedules

  describe "schedules" do
    alias HungerGames.Schedules.Schedule

    @valid_attrs %{name: "some name", registration_end_date: ~U[2021-10-31 15:10:00.000000Z]}
    @invalid_attrs %{name: nil}

    def schedule_fixture(attrs \\ %{}) do
      {:ok, schedule} =
        attrs
        |> Enum.into(@valid_attrs)
        |> HungerGames.Schedules.create_schedule()

      schedule
    end

    test "list_schedules/0 returns all schedules" do
      schedule = schedule_fixture()
      assert Schedules.list_schedules() == [schedule]
    end

    test "get_schedule!/1 returns the schedule with given id" do
      schedule = schedule_fixture()
      assert Schedules.get_schedule!(schedule.id) == schedule
    end

    test "create_schedule/1 with valid data creates a schedule" do
      assert {:ok, %Schedule{} = schedule} = Schedules.create_schedule(@valid_attrs)
      assert schedule.name == "some name"
      assert schedule.registration_end_date == ~U[2021-10-31 15:10:00.000000Z]

      assert_enqueued(
        worker: HungerGames.AssignScheduleWorker,
        args: %{id: schedule.id},
        scheduled_at: {schedule.registration_end_date, delta: 0}
      )
    end

    test "create_schedule/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Schedules.create_schedule(@invalid_attrs)
    end

    test "update_schedule/2 with valid data updates the schedule" do
      schedule = schedule_fixture()
      update_attrs = %{name: "some updated name"}

      assert {:ok, %Schedule{} = schedule} = Schedules.update_schedule(schedule, update_attrs)
      assert schedule.name == "some updated name"
    end

    test "update_schedule/2 with invalid data returns error changeset" do
      schedule = schedule_fixture()
      assert {:error, %Ecto.Changeset{}} = Schedules.update_schedule(schedule, @invalid_attrs)
      assert schedule == Schedules.get_schedule!(schedule.id)
    end

    test "delete_schedule/1 deletes the schedule" do
      schedule = schedule_fixture()
      assert {:ok, %Schedule{}} = Schedules.delete_schedule(schedule)
      assert_raise Ecto.NoResultsError, fn -> Schedules.get_schedule!(schedule.id) end
    end

    test "change_schedule/1 returns a schedule changeset" do
      schedule = schedule_fixture()
      assert %Ecto.Changeset{} = Schedules.change_schedule(schedule)
    end
  end
end
