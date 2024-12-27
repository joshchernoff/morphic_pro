defmodule MorphicProWeb.Router do
  use MorphicProWeb, :router
  import MorphicProWeb.UserAuth

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {MorphicProWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :fetch_current_user
  end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:morphic_pro, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: MorphicProWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end

  scope "/", MorphicProWeb do
    pipe_through [:browser, :redirect_if_user_is_authenticated]

    live_session :redirect_if_user_is_authenticated,
      on_mount: [{MorphicProWeb.UserAuth, :redirect_if_user_is_authenticated}] do
      live "/users/register", UserLive.Registration, :new
      live "/users/log_in", UserLive.Login, :new
      live "/users/reset_password", UserLive.ForgotPassword, :new
      live "/users/reset_password/:token", UserLive.ResetPassword, :edit
    end

    post "/users/log_in", UserSessionController, :create
  end

  scope "/", MorphicProWeb do
    pipe_through [:browser, :require_authenticated_user]

    live_session :admin,
      on_mount: [{MorphicProWeb.UserAuth, :ensure_admin}] do
      live "/admin/comments/:id/edit", AdminLive.Comment, :edit
      live "/admin/comments/:id", AdminLive.Comment, :show
      live "/admin/comments", AdminLive.Comment, :index

      live "/admin/invoices/:id/edit", AdminLive.Invoice, :edit
      live "/admin/invoices/:id", AdminLive.Invoice, :show
      live "/admin/invoices", AdminLive.Invoice, :index

      live "/admin/messages/:id/edit", AdminLive.Message, :edit
      live "/admin/messages/:id", AdminLive.Message, :show
      live "/admin/messages", AdminLive.Message, :index

      live "/admin/orgs/:id/edit", AdminLive.Organization, :edit
      live "/admin/orgs/:id", AdminLive.Organization, :show
      live "/admin/orgs", AdminLive.Organization, :index

      live "/admin/payments/:id/edit", AdminLive.Payment, :edit
      live "/admin/payments/:id", AdminLive.Payment, :show
      live "/admin/payments", AdminLive.Payment, :index

      live "/admin/posts/:id/edit", AdminLive.Post, :edit
      live "/admin/posts/:id", AdminLive.Post, :show
      live "/admin/posts", AdminLive.Post, :index

      live "/admin/projects/:id/edit", AdminLive.Project, :edit
      live "/admin/projects/:id", AdminLive.Project, :show
      live "/admin/projects", AdminLive.Project, :index

      live "/admin/quotes/:id/edit", AdminLive.Quote, :edit
      live "/admin/quotes/:id", AdminLive.Quote, :show
      live "/admin/quotes", AdminLive.Quote, :index

      live "/admin/rfp/:id/edit", AdminLive.RequestForProposal, :edit
      live "/admin/rfp/:id", AdminLive.RequestForProposal, :show
      live "/admin/rfp", AdminLive.RequestForProposal, :index

      live "/admin/tasks/:id/edit", AdminLive.Task, :edit
      live "/admin/tasks/:id", AdminLive.Task, :show
      live "/admin/tasks", AdminLive.Task, :index

      live "/admin/users/:id/edit", AdminLive.User, :edit
      live "/admin/users/:id", AdminLive.User, :show
      live "/admin/users", AdminLive.User, :index

      live "/admin", AdminLive.Dashboard, :dashboard
    end

    live_session :require_authenticated_user,
      on_mount: [{MorphicProWeb.UserAuth, :ensure_authenticated}] do
      live "/users/settings", UserLive.Settings, :edit
      live "/users/settings/confirm_email/:token", UserLive.Settings, :confirm_email
    end
  end

  scope "/", MorphicProWeb do
    pipe_through [:browser]

    get "/users/log_out", UserSessionController, :delete

    live_session :current_user,
      on_mount: [{MorphicProWeb.UserAuth, :mount_current_user}] do
      live "/users/confirm/:token", UserLive.Confirmation, :edit
      live "/users/confirm", UserLive.ConfirmationInstructions, :new

      live "/", PageLive.Home, :home
    end
  end
end
