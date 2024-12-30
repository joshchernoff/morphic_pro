defmodule MorphicProWeb.AdminLive.User.Index do
  use MorphicProWeb, :live_view
  import MorphicProWeb.Layouts, only: [admin_layout: 1, mobile_menu_open: 1]
  import DateUtils

  alias MorphicPro.Users

  @impl true
  def mount(%{"search" => search_params}, _session, socket) do
    search_params = parse_search_params(search_params)

    {:ok,
     socket
     |> assign(:page_title, "Users - Admin - Morphic.Pro")
     |> assign(:search_params, search_params)
     |> assign(:invite_wipe, nil)
     |> stream(:users, MorphicPro.Users.list_users(search_params))}
  end

  def mount(_, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Users - Admin - Morphic.Pro")
     |> assign(:search, nil)
     |> assign(:search_params, %{})
     |> assign(:invite_wipe, nil)
     |> stream(:users, MorphicPro.Users.list_users())}
  end

  @impl true
  def handle_params(%{"search" => search_params}, uri, socket) do
    search_params = parse_search_params(search_params)

    if search_params == socket.assigns.search_params do
      {:noreply, socket |> assign(:uri, uri)}
    else
      {:noreply,
       socket
       |> assign(:uri, uri)
       |> assign(:search_params, search_params)
       |> stream(:users, MorphicPro.Users.list_users(search_params), reset: true)}
    end
  end

  def handle_params(%{}, uri, socket) do
    {:noreply,
     socket
     |> assign(:uri, uri)
     |> assign(:search, nil)
     |> assign(:search_params, %{})
     |> stream(:users, MorphicPro.Users.list_users(), reset: true)}
  end

  @impl true
  def handle_event("search", %{"search" => %{"query" => q}}, socket) do
    search_params = socket.assigns.search_params |> Map.merge(%{query: q})
    {:noreply, socket |> push_patch(to: ~p"/admin/users?#{%{"search" => search_params}}")}
  end

  def handle_event("filter", %{"search" => search_params}, socket) do
    search_params =
      %{
        admin: Map.get(search_params, "admin", ""),
        confirmed: Map.get(search_params, "confirmed", ""),
        order_direction: Map.get(search_params, "order_direction", "desc"),
        order_field: Map.get(search_params, "order_field", "inserted_at"),
        organization: Map.get(search_params, "organization", ""),
        query: Map.get(socket.assigns.search_params, :query, "")
      }
      |> Enum.reject(fn {_key, value} -> value == "" end)
      |> Map.new()
      |> IO.inspect()

    {:noreply, socket |> push_patch(to: ~p"/admin/users?#{%{"search" => search_params}}")}
  end

  def handle_event("clear-search", _unsigned_params, socket) do
    clear_search = socket.assigns.search_params |> Map.delete(:query)
    {:noreply, socket |> push_patch(to: ~p"/admin/users?#{%{"search" => clear_search}}")}
  end

  def handle_event("reset-filter", _unsigned_params, socket) do
    clear_search =
      socket.assigns.search_params
      |> Map.delete(:admin)
      |> Map.delete(:confirmed)
      |> Map.delete(:order_direction)
      |> Map.delete(:order_field)
      |> Map.delete(:organization)
      |> dbg()

    {:noreply, socket |> push_patch(to: ~p"/admin/users?#{%{"search" => clear_search}}")}
  end

  def handle_event("change_invite", %{"user" => %{"email" => email}}, socket) do
    {:noreply, assign(socket, :invite_wipe, email)}
  end

  def handle_event("send_invite", %{"user" => %{"email" => email}}, socket) do
    {:ok, user} =
      Users.register_user(%{
        email: email,
        password: Users.User.generate_password()
      })
      |> dbg()

    Users.deliver_user_invite(
      user,
      &url(~p"/users/invite/#{&1}")
    )

    info =
      "The user was successfully sent an invitation to join the site"

    {:noreply,
     socket
     |> put_flash(:info, info)
     |> stream_insert(:users, user, at: 0)
     |> assign(:invite_wipe, nil)}
  end

  def parse_search_params(search_params) do
    %{
      admin: Map.get(search_params, "admin", ""),
      confirmed: Map.get(search_params, "confirmed", ""),
      order_direction: Map.get(search_params, "order_direction", "desc"),
      order_field: Map.get(search_params, "order_field", "inserted_at"),
      organization: Map.get(search_params, "organization", ""),
      query: Map.get(search_params, "query", "")
    }
    |> Enum.reject(fn {_key, value} -> value == "" end)
    |> Map.new()
  end
end
