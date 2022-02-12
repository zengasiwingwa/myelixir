defmodule FelixirWeb.Schema do
  use Absinthe.Schema

  @desc "query"
  query do
    field :hello, :string do
      resolve(fn _, _, _ -> {:ok, "world"} end)
    end
  end
end
