defmodule MorphicProWeb.AdminLive.User.Show do
  use MorphicProWeb, :live_view
  import MorphicProWeb.Layouts, only: [admin_layout: 1, mobile_menu_open: 1]

  alias MorphicPro.Users

  def handle_params(%{"id" => id}, uri, socket) do
    {:noreply,
     socket
     |> assign(:uri, uri)
     |> assign(:page_title, "User - Admin - Morphic.Pro")
     |> assign(:user, MorphicPro.Users.get_user!(id))}
  end

  def handle_event("delete-user", %{"id" => id}, socket) do
    info = "User #{id} has been deleted"

    Users.delete_user(id)

    {
      :noreply,
      socket
      |> put_flash(:info, info)
      |> push_navigate(to: ~p"/admin/users")
    }
  end
end
