defmodule MorphicPro.MessagesTest do
  use MorphicPro.DataCase

  alias MorphicPro.Messages

  describe "massages" do
    alias MorphicPro.Messages.Message

    import MorphicPro.MessagesFixtures

    @invalid_attrs %{title: nil, body: nil}

    test "list_massages/0 returns all massages" do
      message = message_fixture()
      assert Messages.list_massages() == [message]
    end

    test "get_message!/1 returns the message with given id" do
      message = message_fixture()
      assert Messages.get_message!(message.id) == message
    end

    test "create_message/1 with valid data creates a message" do
      valid_attrs = %{title: "some title", body: "some body"}

      assert {:ok, %Message{} = message} = Messages.create_message(valid_attrs)
      assert message.title == "some title"
      assert message.body == "some body"
    end

    test "create_message/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Messages.create_message(@invalid_attrs)
    end

    test "update_message/2 with valid data updates the message" do
      message = message_fixture()
      update_attrs = %{title: "some updated title", body: "some updated body"}

      assert {:ok, %Message{} = message} = Messages.update_message(message, update_attrs)
      assert message.title == "some updated title"
      assert message.body == "some updated body"
    end

    test "update_message/2 with invalid data returns error changeset" do
      message = message_fixture()
      assert {:error, %Ecto.Changeset{}} = Messages.update_message(message, @invalid_attrs)
      assert message == Messages.get_message!(message.id)
    end

    test "delete_message/1 deletes the message" do
      message = message_fixture()
      assert {:ok, %Message{}} = Messages.delete_message(message)
      assert_raise Ecto.NoResultsError, fn -> Messages.get_message!(message.id) end
    end

    test "change_message/1 returns a message changeset" do
      message = message_fixture()
      assert %Ecto.Changeset{} = Messages.change_message(message)
    end
  end
end
