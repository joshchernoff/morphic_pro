defmodule MorphicProWeb.Layouts do
  @moduledoc """
  This module holds different layouts used by your application.

  See the `layouts` directory for all templates available.
  The "root" layout is a skeleton rendered as part of the
  application router. The "app" layout is set as the default
  layout on both `use MorphicProWeb, :controller` and
  `use MorphicProWeb, :live_view`.
  """
  use MorphicProWeb, :html

  embed_templates "layouts/*"

  attr :current_user, :any, default: nil
  slot :inner_block, required: true

  def layout(assigns) do
    ~H"""
    <div>
      <nav>
        <ul>
          <li><a href="/">Home</a></li>
          <li><a href="#">About</a></li>
          <li><a href="#">Contact</a></li>
        </ul>

        <ul :if={@current_user}>
          <li>{@current_user.email}</li>
          <li><a href={~p"/users/settings"}>Settings</a></li>
          <li><a href={~p"/users/log_out"}>Log out</a></li>
        </ul>

        <ul :if={!@current_user}>
          <li><a href={~p"/users/register"}>Register</a></li>
          <li><a href={~p"/users/log_in"}>Log in</a></li>
        </ul>
      </nav>
      {render_slot(@inner_block)}
    </div>
    """
  end
end
