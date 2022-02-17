defmodule Felixir.Chat.Message.Message do
  use Ecto.Schema
  import Ecto.Changeset

  alias Felixir.Auth.User
  alias Felixir.Chat.Room

  schema "messages" do
    field :content, :string

    belongs_to :user, User
    belongs_to :room, Room
    timestamps()
  end

  @spec changeset(
          {map, map}
          | %{
              :__struct__ => atom | %{:__changeset__ => map, optional(any) => any},
              optional(atom) => any
            },
          :invalid | %{optional(:__struct__) => none, optional(atom | binary) => any}
        ) :: Ecto.Changeset.t()
  @doc false
  def changeset(message, attrs) do
    message
    |> cast(attrs, [:content, :user_id, :room_id])
    |> validate_required([:content, :user_id, :room_id])
    |> validate_length(:content, min: 1, max: 4000)
  end
end
