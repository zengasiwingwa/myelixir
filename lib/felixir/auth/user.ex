defmodule Felixir.Auth.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string
    field :name, :string
    field :password, :string
    field :username, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :email, :username, :password])
    |> validate_required([:name, :email, :username, :password])
    |> unique_constraint(:username)
    |> unique_constraint(:email)
    |> update_change(:email, fn email -> String.downcase(email) end)
    |> validate_length(:password, min: 8, max: 30)
    |> validate_length(:name, min: 2, max: 30)
    |> validate_length(:username, min: 8, max: 30)
    |> validate_format(:email, ~r/@/)
  end
end
