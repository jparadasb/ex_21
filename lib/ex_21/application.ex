defmodule Ex21.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    card_values_seed()
    children = [
      # Start the Ecto repository
      Ex21.Repo,
      # Start the Telemetry supervisor
      Ex21Web.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Ex21.PubSub},
      # Start the Endpoint (http/https)
      Ex21Web.Endpoint
      # Start a worker by calling: Ex21.Worker.start_link(arg)
      # {Ex21.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Ex21.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    Ex21Web.Endpoint.config_change(changed, removed)
    :ok
  end

  defp card_values_seed do
    <<i1 :: unsigned-integer-32, i2 :: unsigned-integer-32, i3 :: unsigned-integer-32>> = :crypto.strong_rand_bytes(12)
    :rand.seed(:exsplus, {i1, i2, i3})
  end
end
