defmodule MorphicProWeb.AdminLive.Dashboard do
  use MorphicProWeb, :live_view
  import MorphicProWeb.Layouts

  def mount(_params, _session, socket) do
    {:ok, socket}
  end
end
