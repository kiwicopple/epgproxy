defmodule Epgproxy.Application do
  use Application

  @impl true
  def start(_type, _args) do
    children = [Epgproxy.Proxy]

    :ranch.start_listener(
      :pg_proxy,
      :ranch_tcp,
      %{socket_opts: [{:port, 5555}]},
      Epgproxy.Server,
      []
    )

    opts = [strategy: :one_for_one, name: Epgproxy.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
