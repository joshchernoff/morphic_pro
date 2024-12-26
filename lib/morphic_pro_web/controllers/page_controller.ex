defmodule MorphicProWeb.PageController do
  use MorphicProWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
