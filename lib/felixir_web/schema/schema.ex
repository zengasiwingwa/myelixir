defmodule FelixirWeb.Schema do
  use Absinthe.Schema

  import_types(FelixirWeb.Schema.Types)

  alias FelixirWeb.Schema.Resolvers

  query do
    @desc "greeting"
    field :hello, :string do
      resolve(fn _, _, _ -> {:ok, "world"} end)
    end

    @desc "Get all users"
    field :users, list_of(:user_type) do
      resolve(&Resolvers.UserResolver.get_all_users/3)
    end
  end
end
