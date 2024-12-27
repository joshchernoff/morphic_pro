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
  attr :flash, :any
  slot :inner_block, required: true

  def layout(assigns) do
    ~H"""
    <nav
      id="navbar"
      class="fixed w-full bg-white/80 backdrop-blur-md shadow-md transition-transform duration-300 transform-gpu z-50"
    >
      <div class="container mx-auto px-6 py-4 flex justify-between items-center">
        <!-- Logo -->
        <a href="/" class="text-2xl font-bold text-gray-900 hover:text-blue-600 transition-colors">
          MORPHIC.PRO
        </a>

        <ul class="hidden md:flex space-x-6 text-gray-700 font-medium">
          <li><a href="/about" class="hover:text-blue-500 transition-colors">About</a></li>
          <li><a href="/services" class="hover:text-blue-500 transition-colors">Services</a></li>
          <li><a href="/contact" class="hover:text-blue-500 transition-colors">Contact</a></li>
        </ul>

        <ul :if={@current_user} class="hidden md:flex space-x-6 text-gray-700 font-medium">
          <li>{@current_user.email}</li>
          <li><a href={~p"/users/settings"}>Settings</a></li>
          <li><a href={~p"/users/log_out"}>Log out</a></li>
        </ul>

        <ul :if={!@current_user} class="hidden md:flex space-x-6 text-gray-700 font-medium">
          <li><a href={~p"/users/register"}>Register</a></li>
          <li><a href={~p"/users/log_in"}>Log in</a></li>
        </ul>

        <button id="menu-btn" class="md:hidden flex items-center text-gray-700">
          <svg
            xmlns="http://www.w3.org/2000/svg"
            fill="none"
            viewBox="0 0 24 24"
            stroke-width="2"
            stroke="currentColor"
            class="w-6 h-6"
          >
            <path stroke-linecap="round" stroke-linejoin="round" d="M4 6h16M4 12h16m-7 6h7" />
          </svg>
        </button>
      </div>

      <div id="mobile-menu" class="hidden bg-white md:hidden shadow-md">
        <ul class="space-y-4 p-4 text-gray-700 font-medium">
          <li><a href="/about" class="block hover:text-blue-500 transition-colors">About</a></li>
          <li>
            <a href="/services" class="block hover:text-blue-500 transition-colors">Services</a>
          </li>
          <li><a href="/contact" class="block hover:text-blue-500 transition-colors">Contact</a></li>
        </ul>

        <ul :if={@current_user} class="space-y-4 p-4 text-gray-700 font-medium">
          <li>{@current_user.email}</li>
          <li><a href={~p"/users/settings"}>Settings</a></li>
          <li><a href={~p"/users/log_out"}>Log out</a></li>
        </ul>

        <ul :if={!@current_user} class="space-y-4 p-4 text-gray-700 font-medium">
          <li><a href={~p"/users/register"}>Register</a></li>
          <li><a href={~p"/users/log_in"}>Log in</a></li>
        </ul>
      </div>
    </nav>

    <div class="pt-20">
      <.flash_group flash={@flash} />

      {render_slot(@inner_block)}
    </div>

    <script>
      let prevScrollPos = window.pageYOffset;
      const navbar = document.getElementById("navbar");

      // Auto-hide Navbar on scroll
      window.onscroll = function () {
          let currentScrollPos = window.pageYOffset;
          if (prevScrollPos > currentScrollPos) {
              navbar.style.transform = "translateY(0)";
          } else {
              navbar.style.transform = "translateY(-100%)";
          }
          prevScrollPos = currentScrollPos;
      };

      // Mobile Menu Toggle
      const menuBtn = document.getElementById("menu-btn");
      const mobileMenu = document.getElementById("mobile-menu");

      menuBtn.addEventListener("click", () => {
          mobileMenu.classList.toggle("hidden");
      });
    </script>
    """
  end

  attr :current_user, :any, default: nil
  slot :inner_block, required: true

  def admin_layout(assigns) do
    ~H"""
    <div>
      <div id="admin-mobile-sidebar" class="relative z-50 xl:hidden" role="dialog" aria-modal="true">
        <div
          id="admin-mobile-sidebar-backdrop"
          phx-click={hide_admin_menu()}
          class="fixed inset-0 bg-gray-900/80 cursor-pointer"
          style="display: none;"
          aria-hidden="true"
        >
        </div>
        <div
          id="admin-mobile-sidebar-menu-wrapper"
          class="w-max fixed inset-0 flex"
          style="display: none;"
        >
          <div
            id="admin-mobile-sidebar-menu"
            class="-translate-x-full transition-all transform ease-in duration-300 relative flex w-full max-w-xs flex-1"
          >
            <.mobile_sidebar_close_btn />
            <.mobile_sidebar current_user={@current_user} links={links()} />
          </div>
        </div>
      </div>
      <.desktop_sidebar current_user={@current_user} links={links()} />
      {render_slot(@inner_block)}
    </div>
    """
  end

  def links() do
    [
      %{name: "Projects", path: ~p"/admin/projects", icon: "hero-folder"},
      %{name: "Tasks", path: ~p"/admin/tasks", icon: "hero-list-bullet"},
      %{name: "RFPs", path: ~p"/admin/rfp", icon: "hero-document-magnifying-glass"},
      %{name: "Quotes", path: ~p"/admin/quotes", icon: "hero-document-text"},
      %{name: "Invoices", path: ~p"/admin/invoices", icon: "hero-document-check"},
      %{name: "Payments", path: ~p"/admin/payments", icon: "hero-credit-card"},
      %{name: "Orgs", path: ~p"/admin/orgs", icon: "hero-building-office"},
      %{name: "Users", path: ~p"/admin/users", icon: "hero-user"},
      %{name: "Messages", path: ~p"/admin/messages", icon: "hero-envelope"},
      %{name: "Posts", path: ~p"/admin/posts", icon: "hero-book-open"},
      %{name: "Comments", path: ~p"/admin/comments", icon: "hero-chat-bubble-left"}
    ]
  end

  def desktop_sidebar(assigns) do
    ~H"""
    <div class="hidden xl:fixed xl:inset-y-0 xl:z-50 xl:flex xl:w-72 xl:flex-col">
      <div class="flex grow flex-col gap-y-5 overflow-y-auto bg-black/10 px-6 ring-1 ring-white/5">
        <div class="flex h-16 shrink-0 items-center">
          <.logo />
        </div>
        <nav class="flex flex-1 flex-col">
          <ul role="list" class="flex flex-1 flex-col gap-y-7">
            <li>
              <ul role="list" class="-mx-2 space-y-1">
                <%= for link <- @links do %>
                  <.desktop_menu_item link={link} />
                <% end %>
              </ul>
            </li>

            <.current_user_item current_user={@current_user} />
          </ul>
        </nav>
      </div>
    </div>
    """
  end

  attr :links, :list, required: true

  def mobile_sidebar(assigns) do
    ~H"""
    <div class="flex grow flex-col gap-y-5 overflow-y-auto bg-gray-900 px-6 ring-1 ring-white/10">
      <div class="flex h-16 shrink-0 items-center">
        <.logo />
      </div>
      <nav class="flex flex-1 flex-col">
        <ul role="list" class="flex flex-1 flex-col gap-y-7">
          <li>
            <ul role="list" class="-mx-2 space-y-1">
              <%= for link <- @links do %>
                <.mobile_menu_item link={link} />
              <% end %>
            </ul>
          </li>

          <.current_user_item current_user={@current_user} />
        </ul>
      </nav>
    </div>
    """
  end

  def mobile_sidebar_close_btn(assigns) do
    ~H"""
    <div
      phx-click={hide_admin_menu()}
      id="admin-mobile-menu-button"
      class="absolute left-full top-0 flex w-16 justify-center pt-5"
    >
      <button type="button" class="-m-2.5 p-2.5">
        <span class="sr-only">Close sidebar</span>
        <.icon name="hero-x-mark" class="w-6 h-6 bg-zinc-100" />
      </button>
    </div>
    """
  end

  def desktop_menu_item(assigns) do
    ~H"""
    <li>
      <!-- Current: "bg-gray-800 text-white", Default: "text-gray-400 hover:text-white hover:bg-gray-800" -->
      <.link
        navigate={@link.path}
        class="group flex gap-x-3 rounded-md p-2 text-sm/6 font-semibold text-gray-400 hover:bg-gray-800 hover:text-white"
      >
        <.icon name={@link.icon} class="w-6 h-6" /> {@link.name}
      </.link>
    </li>
    """
  end

  attr :link, :any

  def mobile_menu_item(assigns) do
    ~H"""
    <li>
      <!-- Current: "bg-gray-800 text-white", Default: "text-gray-400 hover:text-white hover:bg-gray-800" -->
      <a
        href={@link.path}
        class="group flex gap-x-3 rounded-md p-2 text-sm/6 font-semibold text-gray-400 hover:bg-gray-800 hover:text-white"
      >
        <.icon name={@link.icon} class="w-6 h-6" /> {@link.name}
      </a>
    </li>
    """
  end

  def logo(assigns) do
    ~H"""
    <img
      class="h-8 w-auto"
      src="https://tailwindui.com/plus/img/logos/mark.svg?color=indigo&shade=500"
      alt="Morphic.Pro"
    />
    """
  end

  def current_user_item(assigns) do
    ~H"""
    <li class="-mx-6 mt-auto">
      <a
        href="/users/settings"
        class="flex items-center gap-x-4 px-6 py-3 text-sm/6 font-semibold text-white hover:bg-gray-800"
      >
        <img
          class="size-8 rounded-full bg-gray-800"
          src="https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=facearea&facepad=2&w=256&h=256&q=80"
          alt=""
        />
        <span class="sr-only">Your profile</span>
        <span aria-hidden="true">{@current_user.email}</span>
      </a>
    </li>
    """
  end

  def show_admin_menu(js \\ %JS{}) do
    js
    |> JS.show(
      to: "#admin-mobile-sidebar-backdrop",
      time: 300,
      transition: {"transition-all transform ease-in duration-300", "opacity-0", "opacity-100"},
      display: "block"
    )
    |> JS.show(
      to: "#admin-mobile-sidebar-menu-wrapper",
      transition: {"transition-all transform ease-in duration-300", "opacity-0", "opacity-100"},
      time: 300,
      display: "flex"
    )
    |> JS.remove_class(
      "-translate-x-full",
      transition: {"transition-all transform ease-in duration-300", "-translate-x-full", ""},
      to: "#admin-mobile-sidebar-menu"
    )
  end

  def hide_admin_menu(js \\ %JS{}) do
    js
    |> JS.hide(
      to: "#admin-mobile-sidebar-backdrop",
      time: 600,
      transition:
        {"transition-all transform ease-in duration-300  delay-300", "opacity-100", "opacity-0"}
    )
    |> JS.hide(
      to: "#admin-mobile-sidebar-menu-wrapper",
      transition:
        {"transition-all transform ease-in duration-300  delay-300", "opacity-100", "opacity-0"},
      time: 600
    )
    |> JS.add_class(
      "-translate-x-full",
      transition:
        {"transition-all transform ease-in duration-300", "-translate-x-0", "-translate-x-full"},
      to: "#admin-mobile-sidebar-menu"
    )
  end
end
