defmodule Trelix.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      TrelixWeb.Telemetry,
      Trelix.Repo,
      {DNSCluster, query: Application.get_env(:trelix, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Trelix.PubSub},
      # Start a worker by calling: Trelix.Worker.start_link(arg)
      # {Trelix.Worker, arg},
      # Start to serve requests, typically the last entry
      TrelixWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Trelix.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    TrelixWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
