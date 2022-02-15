defmodule FelixirWeb.Schema.Resolvers.UserResolver do
  alias Felixir.Auth

  def get_all_users(_, _, %{context: context}) do
    IO.puts("Grabbing the xonrt")
    IO.inspect(context)
    {:ok, Auth.list_users()}
  end
end
