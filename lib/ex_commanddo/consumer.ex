defmodule ExCommanddo.Consumer do
  use GenStage

  @concurrency 1

  def start_link(opts) do
    concurrency = opts[:concurrency] || @concurrency

    GenStage.start_link(__MODULE__, concurrency)
  end

  def init(concurrency) do
    {:consumer, concurrency,
     subscribe_to: [{ExCommanddo.Producer, min_demand: 0, max_demand: concurrency}]}
  end

  def handle_events(events, _from, state) do
    tasks =
      for event <- events do
        Task.async(fn ->
          cmd(event)
        end)
      end

    _ = Task.yield_many(tasks, :infinity)

    {:noreply, [], state}
  end

  defp cmd(event) do
    # @TODO actual work
    Process.sleep(51)

    event
  end
end
