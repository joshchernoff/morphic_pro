defmodule MorphicProWeb.PageHTML do
  @moduledoc """
  This module contains pages rendered by PageController.

  See the `page_html` directory for all templates available.
  """
  use MorphicProWeb, :html
  import MorphicProWeb.Layouts

  embed_templates "page_html/*"
end
