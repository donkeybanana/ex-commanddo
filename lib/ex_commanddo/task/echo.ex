defmodule ExCommanddo.Task.Echo do
  use ExCommanddo.Task,
    name: "echo",
    cmd: &__MODULE__.cmd/1

  def cmd(event) do
    IO.puts("ExCommand.Task.Echo: #{inspect(event.value)}")

    event
  end
end
