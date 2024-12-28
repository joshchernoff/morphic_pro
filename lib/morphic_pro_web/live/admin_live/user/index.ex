defmodule MorphicProWeb.AdminLive.User.Index do
  use MorphicProWeb, :live_view
  import MorphicProWeb.Layouts, only: [admin_layout: 1, mobile_menu_open: 1]

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Users - Admin - Morphic.Pro")
     |> assign(:search, nil)
     |> stream(:users, MorphicPro.Users.list_users())}
  end

  @impl true
  def handle_params(%{"search" => q}, uri, socket) do
    _opts = %{query: q, current_user: socket.assigns.current_user}
    new_users = MorphicPro.Users.list_users()

    {:noreply,
     socket
     |> assign(:uri, uri)
     |> stream(:users, new_users, reset: true)
     |> assign(:search, q)}
  end

  def handle_params(_unsigned_params, uri, socket) do
    {:noreply, socket |> assign(:uri, uri) |> assign(:search, nil)}
  end

  @impl true
  def handle_event("search", %{"search" => query}, socket) do
    {:noreply, socket |> push_patch(to: ~p"/admin/users?search=#{query}")}
  end

  def handle_event("clear-search", _unsigned_params, socket) do
    {:noreply, socket |> push_patch(to: ~p"/admin/users")}
  end
end
