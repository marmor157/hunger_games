defmodule HungerGames.LecturersTest do
  use HungerGames.DataCase

  alias HungerGames.Lecturers

  describe "lecturers" do
    alias HungerGames.Lecturers.Lecturer

    import HungerGames.LecturersFixtures

    @invalid_attrs %{name: nil}

    test "list_lecturers/0 returns all lecturers" do
      lecturer = lecturer_fixture()
      assert Lecturers.list_lecturers() == [lecturer]
    end

    test "get_lecturer!/1 returns the lecturer with given id" do
      lecturer = lecturer_fixture()
      assert Lecturers.get_lecturer!(lecturer.id) == lecturer
    end

    test "create_lecturer/1 with valid data creates a lecturer" do
      valid_attrs = %{name: "some name"}

      assert {:ok, %Lecturer{} = lecturer} = Lecturers.create_lecturer(valid_attrs)
      assert lecturer.name == "some name"
    end

    test "create_lecturer/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Lecturers.create_lecturer(@invalid_attrs)
    end

    test "update_lecturer/2 with valid data updates the lecturer" do
      lecturer = lecturer_fixture()
      update_attrs = %{name: "some updated name"}

      assert {:ok, %Lecturer{} = lecturer} = Lecturers.update_lecturer(lecturer, update_attrs)
      assert lecturer.name == "some updated name"
    end

    test "update_lecturer/2 with invalid data returns error changeset" do
      lecturer = lecturer_fixture()
      assert {:error, %Ecto.Changeset{}} = Lecturers.update_lecturer(lecturer, @invalid_attrs)
      assert lecturer == Lecturers.get_lecturer!(lecturer.id)
    end

    test "delete_lecturer/1 deletes the lecturer" do
      lecturer = lecturer_fixture()
      assert {:ok, %Lecturer{}} = Lecturers.delete_lecturer(lecturer)
      assert_raise Ecto.NoResultsError, fn -> Lecturers.get_lecturer!(lecturer.id) end
    end

    test "change_lecturer/1 returns a lecturer changeset" do
      lecturer = lecturer_fixture()
      assert %Ecto.Changeset{} = Lecturers.change_lecturer(lecturer)
    end
  end
end
