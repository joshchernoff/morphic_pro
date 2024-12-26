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
      <nav>
        <ul>
          <li>ADMIN Page</li>
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
