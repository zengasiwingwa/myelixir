defmodule FelixirWeb.AuthController do
  use FelixirWeb, :controller

  def index(conn, _params) do
    render(conn, "acknowledge.json", %{message: "hello"})
  end
end
