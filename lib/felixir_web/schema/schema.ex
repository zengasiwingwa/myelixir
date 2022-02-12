defmodule FelixirWeb.Schema do
  use Absinthe.Schema


  query do
    @desc "greeting"
    field :hello, :string do
      resolve(fn _, _, _ -> {:ok, "world"} end)
    end
  end
end
