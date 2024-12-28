defmodule MorphicProWeb.AdminLive.Organization.Index do
  use MorphicProWeb, :live_view
  import MorphicProWeb.Layouts, only: [admin_layout: 1, mobile_menu_open: 1]

  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Organizations - Admin - Morphic.Pro")
     |> stream(:organizations, MorphicPro.Organizations.list_organizations())}
  end

  def handle_params(_unsigned_params, uri, socket) do
    {:noreply, socket |> assign(:uri, uri)}
  end
end
