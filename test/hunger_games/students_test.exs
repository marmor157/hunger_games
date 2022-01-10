defmodule HungerGames.StudentsTest do
  use HungerGames.DataCase

  alias HungerGames.Students

  describe "students" do
    alias HungerGames.Students.{Encryption, Student}

    @valid_attrs %{name: "some name", email: "some@email.com", password: "123"}
    @invalid_attrs %{name: nil}

    def student_fixture(attrs \\ %{}) do
      attrs
      |> Enum.into(@valid_attrs)
      |> HungerGames.Students.create_student()
      |> elem(1)
      |> Map.put(:password, nil)
    end

    test "list_students/0 returns all students" do
      student = student_fixture()
      assert Students.list_students() == [student]
    end

    test "get_student!/1 returns the student with given id" do
      student = student_fixture()
      assert student.email == @valid_attrs.email
      assert student.name == @valid_attrs.name
      assert Encryption.validate_password(student, @valid_attrs.password)
    end

    test "create_student/1 with valid data creates a student" do
      assert {:ok, %Student{} = student} = Students.create_student(@valid_attrs)
      assert student.name == @valid_attrs.name
      assert student.email == @valid_attrs.email
      assert Encryption.validate_password(student, @valid_attrs.password)
    end

    test "create_student/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Students.create_student(@invalid_attrs)
    end

    test "update_student/2 with valid data updates the student" do
      student = student_fixture()
      update_attrs = %{name: "some updated name"}

      assert {:ok, %Student{} = student} = Students.update_student(student, update_attrs)
      assert student.name == "some updated name"
    end

    test "update_student/2 with invalid data returns error changeset" do
      student = student_fixture()
      assert {:error, %Ecto.Changeset{}} = Students.update_student(student, @invalid_attrs)
      assert student.name == @valid_attrs.name
    end

    test "delete_student/1 deletes the student" do
      student = student_fixture()
      assert {:ok, %Student{}} = Students.delete_student(student)
      assert_raise Ecto.NoResultsError, fn -> Students.get_student!(student.id) end
    end

    test "change_student/1 returns a student changeset" do
      student = student_fixture()
      assert %Ecto.Changeset{} = Students.change_student(student)
    end
  end
end
