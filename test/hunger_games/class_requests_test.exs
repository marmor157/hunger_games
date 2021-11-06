defmodule HungerGames.ClassRequestsTest do
  use HungerGames.DataCase

  alias HungerGames.ClassRequests

  import HungerGames.Factory

  describe "class_requests" do
    alias HungerGames.ClassRequests.ClassRequest

    @valid_attrs %{priority: 42}
    @invalid_attrs %{priority: nil}

    setup do
      student = insert(:student)
      schedule = insert(:schedule)
      class = insert(:class, schedule: schedule)
      request = insert(:request, student: student, schedule: schedule)

      [
        student_id: student.id,
        student: student,
        schedule_id: schedule.id,
        schedule: schedule,
        class_id: class.id,
        class: class,
        request_id: request.id,
        request: request
      ]
    end

    def class_request_fixture(attrs \\ %{}) do
      {:ok, class_request} =
        attrs
        |> Enum.into(@valid_attrs)
        |> HungerGames.ClassRequests.create_class_request()

      class_request
    end

    test "list_class_requests/0 returns all class_requests", ctx do
      class_request = class_request_fixture(ctx)
      assert ClassRequests.list_class_requests() == [class_request]
    end

    test "get_class_request!/1 returns the class_request with given id", ctx do
      class_request = class_request_fixture(ctx)
      assert ClassRequests.get_class_request!(class_request.id) == class_request
    end

    test "create_class_request/1 with valid data creates a class_request", ctx do
      assert {:ok, %ClassRequest{} = class_request} =
               ClassRequests.create_class_request(Map.merge(@valid_attrs, ctx))

      assert class_request.priority == @valid_attrs.priority
    end

    test "create_class_request/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = ClassRequests.create_class_request(@invalid_attrs)
    end

    test "update_class_request/2 with valid data updates the class_request", ctx do
      class_request = class_request_fixture(ctx)
      update_attrs = %{priority: 43}

      assert {:ok, %ClassRequest{} = class_request} =
               ClassRequests.update_class_request(class_request, update_attrs)

      assert class_request.priority == 43
    end

    test "update_class_request/2 with invalid data returns error changeset", ctx do
      class_request = class_request_fixture(ctx)

      assert {:error, %Ecto.Changeset{}} =
               ClassRequests.update_class_request(class_request, @invalid_attrs)

      assert class_request == ClassRequests.get_class_request!(class_request.id)
    end

    test "delete_class_request/1 deletes the class_request", ctx do
      class_request = class_request_fixture(ctx)
      assert {:ok, %ClassRequest{}} = ClassRequests.delete_class_request(class_request)

      assert_raise Ecto.NoResultsError, fn ->
        ClassRequests.get_class_request!(class_request.id)
      end
    end

    test "change_class_request/1 returns a class_request changeset", ctx do
      class_request = class_request_fixture(ctx)
      assert %Ecto.Changeset{} = ClassRequests.change_class_request(class_request)
    end
  end
end
