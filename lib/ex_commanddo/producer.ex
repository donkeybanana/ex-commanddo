defmodule ExCommanddo.Producer do
  use GenStage

  @interval 60_000

  def start_link(opts \\ []) do
    GenStage.start_link(__MODULE__, opts, name: __MODULE__)
  end

  def init(interval: interval, jobs: jobs) do
    interval = interval || @interval

    {
      :producer,
      queue_jobs(jobs, interval),
      # Keep the head of the buffer when we overflow,
      # as demand is taken from the head of the queue
      buffer_keep: :first
    }
  end

  def handle_demand(demand, queue) when demand > 0 do
    {jobs, remainder} = Enum.split(queue, demand)

    {:noreply, jobs, remainder}
  end

  def handle_info({:queue, jobs, interval}, state) do
    {:noreply, state ++ queue_jobs(jobs, interval), state}
  end

  defp queue_jobs(jobs, interval) do
    Process.send_after(self(), {:queue, jobs, interval}, interval)

    jobs
  end
end
