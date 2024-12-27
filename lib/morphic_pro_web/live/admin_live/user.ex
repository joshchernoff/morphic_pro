defmodule MorphicProWeb.AdminLive.User do
  use MorphicProWeb, :live_view
  import MorphicProWeb.Layouts, only: [admin_layout: 1]

  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> stream(:users, MorphicPro.Users.list_users())}
  end
end
