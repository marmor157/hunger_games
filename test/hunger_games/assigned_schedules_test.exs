defmodule HungerGames.AssignedSchedulesTest do
  use HungerGames.DataCase

  alias HungerGames.AssignedSchedules

  import HungerGames.Factory

  describe "assigned_schedules" do
    alias HungerGames.AssignedSchedules.AssignedSchedule

    @valid_attrs %{}
    # @invalid_attrs %{}

    setup do
      student = insert(:student)
      schedule = insert(:schedule)

      [student_id: student.id, student: student, schedule_id: schedule.id, schedule: schedule]
    end

    def assigned_schedule_fixture(attrs \\ %{}) do
      {:ok, assigned_schedule} =
        attrs
        |> Enum.into(@valid_attrs)
        |> HungerGames.AssignedSchedules.create_assigned_schedule()

      assigned_schedule
    end

    test "list_assigned_schedules/0 returns all assigned_schedules", ctx do
      assigned_schedule = assigned_schedule_fixture(ctx)
      assert AssignedSchedules.list_assigned_schedules() == [assigned_schedule]
    end

    test "get_assigned_schedule!/1 returns the assigned_schedule with given id", ctx do
      assigned_schedule = assigned_schedule_fixture(ctx)
      assert AssignedSchedules.get_assigned_schedule!(assigned_schedule.id) == assigned_schedule
    end

    test "create_assigned_schedule/1 with valid data creates a assigned_schedule", ctx do
      assert {:ok, %AssignedSchedule{} = _assigned_schedule} =
               AssignedSchedules.create_assigned_schedule(Map.merge(@valid_attrs, ctx))
    end

    # test "create_assigned_schedule/1 with invalid data returns error changeset" do
    #   assert {:error, %Ecto.Changeset{}} =
    #            AssignedSchedules.create_assigned_schedule(@invalid_attrs)
    # end

    test "update_assigned_schedule/2 with valid data updates the assigned_schedule", ctx do
      assigned_schedule = assigned_schedule_fixture(ctx)
      update_attrs = %{}

      assert {:ok, %AssignedSchedule{} = _assigned_schedule} =
               AssignedSchedules.update_assigned_schedule(assigned_schedule, update_attrs)
    end

    # test "update_assigned_schedule/2 with invalid data returns error changeset", ctx do
    #   assigned_schedule = assigned_schedule_fixture(ctx)

    #   assert {:error, %Ecto.Changeset{}} =
    #            AssignedSchedules.update_assigned_schedule(assigned_schedule, @invalid_attrs)

    #   assert assigned_schedule == AssignedSchedules.get_assigned_schedule!(assigned_schedule.id)
    # end

    test "delete_assigned_schedule/1 deletes the assigned_schedule", ctx do
      assigned_schedule = assigned_schedule_fixture(ctx)

      assert {:ok, %AssignedSchedule{}} =
               AssignedSchedules.delete_assigned_schedule(assigned_schedule)

      assert_raise Ecto.NoResultsError, fn ->
        AssignedSchedules.get_assigned_schedule!(assigned_schedule.id)
      end
    end

    test "change_assigned_schedule/1 returns a assigned_schedule changeset", ctx do
      assigned_schedule = assigned_schedule_fixture(ctx)
      assert %Ecto.Changeset{} = AssignedSchedules.change_assigned_schedule(assigned_schedule)
    end
  end
end
