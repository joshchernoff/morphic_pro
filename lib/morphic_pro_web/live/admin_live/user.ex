defmodule MorphicProWeb.AdminLive.User do
  use MorphicProWeb, :live_view
  import MorphicProWeb.Layouts, only: [admin_layout: 1, mobile_menu_open: 1]

  def mount(%{"id" => id}, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Show User")
     |> assign(:user, MorphicPro.Users.get_user!(id))
     |> stream(:users, MorphicPro.Users.list_users())}
  end

  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Users")
     |> assign(:user, nil)
     |> stream(:users, MorphicPro.Users.list_users())}
  end

  def handle_params(%{"id" => id}, _uri, socket) do
    {:noreply,
     socket
     |> assign(:page_title, "Show User")
     |> assign(:user, MorphicPro.Users.get_user!(id))}
  end

  def handle_params(_unsigned_params, _uri, socket) do
    {:noreply,
     socket
     |> assign(:page_title, "Users")
     |> assign(:user, nil)}
  end
end
