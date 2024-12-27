defmodule MorphicProWeb.AdminLive.Payment do
  use MorphicProWeb, :live_view
  import MorphicProWeb.Layouts, only: [admin_layout: 1]

  def mount(_params, _session, socket) do
    {:ok, socket}
  end
end
