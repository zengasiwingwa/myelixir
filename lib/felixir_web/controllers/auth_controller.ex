defmodule FelixirWeb.AuthController do
  use FelixirWeb, :controller

  alias Felixir.Auth
  alias FelixirWeb.Utils
  alias FelixirWeb.Constants

  def register(conn, params) do
    case Auth.create_user(params) do
      {:ok, _} ->
        render(conn, "acknowledge.json", %{success: true, message: "Registered!"})

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "errors.json", %{
          success: false,
          errors: Utils.format_changeset_errors(changeset)
        })

      {_, _} ->
        render(conn, "errors.json", %{success: false, message: Constants.internal_server_error()})
    end
  end
end
