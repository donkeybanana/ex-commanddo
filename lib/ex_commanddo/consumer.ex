defmodule ExCommanddo.Consumer do
  use GenStage

  @concurrency 1

  def start_link(concurrency: concurrency) do
    concurrency = concurrency || @concurrency

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
          event.cmd.(event)
        end)
      end

    _ = Task.yield_many(tasks, :infinity)

    {:noreply, [], state}
  end
end
