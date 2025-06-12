defmodule Mastermind.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      MastermindWeb.Telemetry,
      Mastermind.Repo,
      {DNSCluster, query: Application.get_env(:mastermind, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Mastermind.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Mastermind.Finch},
      # Start a worker by calling: Mastermind.Worker.start_link(arg)
      # {Mastermind.Worker, arg},
      # Start to serve requests, typically the last entry
      MastermindWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Mastermind.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    MastermindWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
