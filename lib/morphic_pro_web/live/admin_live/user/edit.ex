defmodule MorphicProWeb.AdminLive.User.Edit do
  use MorphicProWeb, :live_view
  import MorphicProWeb.Layouts, only: [admin_layout: 1, mobile_menu_open: 1]

  def handle_params(%{"id" => id}, uri, socket) do
    {:noreply,
     socket
     |> assign(:uri, uri)
     |> assign(:page_title, "Edit User - Admin - Morphic.Pro")
     |> assign(:user, MorphicPro.Users.get_user!(id))}
  end
end
