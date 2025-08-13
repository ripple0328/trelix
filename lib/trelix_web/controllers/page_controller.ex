defmodule TrelixWeb.PageController do
  use TrelixWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
