defmodule HungerGames.ClassesTest do
  use HungerGames.DataCase

  alias HungerGames.Classes

  import HungerGames.Factory

  describe "classes" do
    alias HungerGames.Classes.Class

    @valid_attrs %{
      name: "some name",
      rrule: "RRULE:FREQ=DAILY;INTERVAL=1",
      size_limit: 42,
      type: :lecture
    }
    @invalid_attrs %{name: nil, rrule: nil, size_limit: nil, type: nil}

    setup do
      schedule = insert(:schedule)
      lecturer = insert(:lecturer)

      [schedule_id: schedule.id, schedule: schedule, lecturer: lecturer, lecturer_id: lecturer.id]
    end

    def class_fixture(attrs \\ %{}) do
      {:ok, class_request} =
        attrs
        |> Enum.into(@valid_attrs)
        |> HungerGames.Classes.create_class()

      class_request
    end

    test "list_classes/0 returns all classes", ctx do
      class = class_fixture(ctx)
      assert Classes.list_classes() == [class]
    end

    test "get_class!/1 returns the class with given id", ctx do
      class = class_fixture(ctx)
      assert Classes.get_class!(class.id) == class
    end

    test "create_class/1 with valid data creates a class", ctx do
      assert {:ok, %Class{} = class} = Classes.create_class(Map.merge(@valid_attrs, ctx))
      assert class.name == @valid_attrs.name
      assert class.rrule == @valid_attrs.rrule
      assert class.size_limit == @valid_attrs.size_limit
      assert class.type == @valid_attrs.type
    end

    test "create_class/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Classes.create_class(@invalid_attrs)
    end

    test "update_class/2 with valid data updates the class", ctx do
      class = class_fixture(ctx)

      update_attrs = %{
        name: "some updated name",
        rrule: "some updated rrule",
        size_limit: 43,
        type: "some updated type"
      }

      assert {:ok, %Class{} = class} = Classes.update_class(class, update_attrs)
      assert class.name == "some updated name"
      assert class.rrule == "some updated rrule"
      assert class.size_limit == 43
      assert class.type == "some updated type"
    end

    test "update_class/2 with invalid data returns error changeset", ctx do
      class = class_fixture(ctx)
      assert {:error, %Ecto.Changeset{}} = Classes.update_class(class, @invalid_attrs)
      assert class == Classes.get_class!(class.id)
    end

    test "delete_class/1 deletes the class", ctx do
      class = class_fixture(ctx)
      assert {:ok, %Class{}} = Classes.delete_class(class)
      assert_raise Ecto.NoResultsError, fn -> Classes.get_class!(class.id) end
    end

    test "change_class/1 returns a class changeset", ctx do
      class = class_fixture(ctx)
      assert %Ecto.Changeset{} = Classes.change_class(class)
    end
  end
end
