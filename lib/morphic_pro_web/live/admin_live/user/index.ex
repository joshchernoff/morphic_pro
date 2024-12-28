defmodule MorphicProWeb.AdminLive.User.Index do
  use MorphicProWeb, :live_view
  import MorphicProWeb.Layouts, only: [admin_layout: 1, mobile_menu_open: 1]

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Users - Admin - Morphic.Pro")
     |> stream(:users, MorphicPro.Users.list_users())}
  end

  @impl true
  def handle_params(_unsigned_params, uri, socket) do
    {:noreply, socket |> assign(:uri, uri)}
  end
end
