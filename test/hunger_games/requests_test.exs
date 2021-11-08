defmodule HungerGames.RequestsTest do
  use HungerGames.DataCase

  alias HungerGames.Requests

  import HungerGames.Factory

  describe "requests" do
    alias HungerGames.Requests.Request

    @valid_attrs %{date: ~U[2021-10-31 15:10:00.000000Z]}
    @invalid_attrs %{date: nil}

    setup do
      student = insert(:student)
      schedule = insert(:schedule)

      [student_id: student.id, student: student, schedule_id: schedule.id, schedule: schedule]
    end

    def request_fixture(attrs \\ %{}) do
      {:ok, request} =
        attrs
        |> Enum.into(@valid_attrs)
        |> HungerGames.Requests.create_request()

      request
    end

    test "list_requests/0 returns all requests", ctx do
      request = request_fixture(ctx)
      assert Requests.list_requests() == [request]
    end

    test "get_request!/1 returns the request with given id", ctx do
      request = request_fixture(ctx)
      assert Requests.get_request!(request.id) == request
    end

    @tag :work
    test "create_request/1 with valid data and list of classes create a request and class_requests",
         ctx do
      lecturer = insert(:lecturer)
      %{id: class1_id} = class1 = insert(:class, schedule: ctx.schedule, lecturer: lecturer)
      %{id: class2_id} = class2 = insert(:class, schedule: ctx.schedule, lecturer: lecturer)

      assert {:ok, %Request{id: request_id} = request} =
               @valid_attrs
               |> Map.merge(ctx)
               |> Map.put(:classes, [
                 %{priority: 1, class_id: class1.id},
                 %{priority: 2, class_id: class2.id}
               ])
               |> Requests.create_request()

      request_classes = request |> Repo.preload(:class_requests) |> Map.get(:class_requests)

      assert [
               %{
                 priority: 1,
                 class_id: ^class1_id,
                 request_id: ^request_id
               },
               %{
                 priority: 2,
                 class_id: ^class2_id,
                 request_id: ^request_id
               }
             ] = request_classes
    end

    test "create_request/1 with valid data creates a request", ctx do
      assert {:ok, %Request{} = request} = Requests.create_request(Map.merge(@valid_attrs, ctx))
      assert request.date == @valid_attrs.date
    end

    test "create_request/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Requests.create_request(@invalid_attrs)
    end

    test "update_request/2 with valid data updates the request", ctx do
      request = request_fixture(ctx)
      update_attrs = %{date: ~U[2021-11-01 15:10:00.000000Z]}

      assert {:ok, %Request{} = request} = Requests.update_request(request, update_attrs)
      assert request.date == ~U[2021-11-01 15:10:00.000000Z]
    end

    test "update_request/2 with invalid data returns error changeset", ctx do
      request = request_fixture(ctx)
      assert {:error, %Ecto.Changeset{}} = Requests.update_request(request, @invalid_attrs)
      assert request == Requests.get_request!(request.id)
    end

    test "delete_request/1 deletes the request", ctx do
      request = request_fixture(ctx)
      assert {:ok, %Request{}} = Requests.delete_request(request)
      assert_raise Ecto.NoResultsError, fn -> Requests.get_request!(request.id) end
    end

    test "change_request/1 returns a request changeset", ctx do
      request = request_fixture(ctx)
      assert %Ecto.Changeset{} = Requests.change_request(request)
    end
  end
end
