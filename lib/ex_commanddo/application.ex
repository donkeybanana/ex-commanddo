defmodule ExCommanddo.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      {ExCommanddo.Producer, interval: 5_000, jobs: 1..10_000 |> Enum.to_list()}
    ]

    workers =
      1..100
      |> Enum.to_list()
      |> Enum.map(fn id ->
        %{id: id, start: {ExCommanddo.Consumer, :start_link, [[concurrency: 1]]}}
      end)

    opts = [strategy: :one_for_one, name: ExCommanddo.Supervisor]
    Supervisor.start_link(children ++ workers, opts)
  end
end
