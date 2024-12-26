defmodule MorphicPro.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      MorphicProWeb.Telemetry,
      MorphicPro.Repo,
      {DNSCluster, query: Application.get_env(:morphic_pro, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: MorphicPro.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: MorphicPro.Finch},
      # Start a worker by calling: MorphicPro.Worker.start_link(arg)
      # {MorphicPro.Worker, arg},
      # Start to serve requests, typically the last entry
      MorphicProWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: MorphicPro.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    MorphicProWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
