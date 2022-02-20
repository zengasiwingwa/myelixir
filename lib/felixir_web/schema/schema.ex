defmodule FelixirWeb.Schema do
  use Absinthe.Schema

  import_types(FelixirWeb.Schema.Types)

  alias FelixirWeb.Schema.Resolvers
  alias FelixirWeb.Topics

  query do
    @desc "greeting"
    field :hello, :string do
      resolve(fn _, _, _ -> {:ok, "world"} end)
    end

    @desc "Get all users"
    field :users, list_of(:user_type) do
      resolve(&Resolvers.UserResolver.get_all_users/3)
    end

    @desc "Get all rooms"
    field :rooms, list_of(:room_type) do
      resolve(&Resolvers.RoomResolver.get_all_rooms/3)
    end

    @desc "Get all messages"
    field :messages, list_of(:message_type) do
      arg(:input, non_null(:list_messages_type))
      resolve(&Resolvers.MessageResolver.get_all_messages/3)
    end

    @desc "Get Me"
    field :get_me, :user_type do
      resolve(&Resolvers.UserResolver.get_me/3)
    end
  end

  mutation do
    @desc "Create Room"
    field :create_room, :boolean do
      arg(:input, non_null(:room_input_type))
      resolve(&Resolvers.RoomResolver.create_room/3)
    end

    @desc "Create Message"
    field :create_message, :message_type do
      arg(:input, non_null(:message_input_type))
      resolve(&Resolvers.MessageResolver.create_message/3)
    end

    @desc "Delete Room"
    field :delete_room, :boolean do
      arg(:input, non_null(:delete_room_type))
      resolve(&Resolvers.RoomResolver.delete_room/3)
    end

    @desc "Delete Message"
    field :delete_message, :deleted_message_type do
      arg(:input, non_null(:delete_message_input))
      resolve(&Resolvers.MessageResolver.delete_message/3)
    end
  end

  subscription do
    @desc "New Message"
    field :new_message, :message_type do
      arg(:input, non_null(:delete_room_type))

      config(fn %{input: input}, _ ->
        IO.puts("Config - Topic being recieved here!")
        IO.inspect(input)
        {:ok, topic: "#{input.room_id}:#{Topics.new_message()}"}
      end)

      trigger(:create_message,
      topic: fn new_message ->
        IO.puts("Trigger -- New message created!")
        IO.inspect(new_message)
        "#{new_message.room_id}:#{Topics.new_message()}"
      end)

      resolve(fn new_message, _, _ ->
        {:ok, new_message}
      end)
    end

    @desc "Deleted Message"
    field :deleted_message, :deleted_message_type do
      arg(:input, non_null(:deleted_message_input))

      config(fn %{input: input}, _ ->
        IO.puts("Config - Topic being deleted here!")
        IO.inspect(input)
        {:ok, topic: "#{input.room_id}:#{Topics.deleted_message()}"}
      end)

      trigger(:delete_message,
      topic: fn %{room_id: room_id} ->
        "#{room_id}:#{Topics.deleted_message()}"
      end)

      resolve(fn payload, _, _ ->
        {:ok, payload}
      end)
    end
  end
end
