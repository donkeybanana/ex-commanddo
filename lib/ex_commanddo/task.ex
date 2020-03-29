defmodule ExCommanddo.Task do
  @fields [
    cmd: &__MODULE__.cmd/1,
    name: "noop",
    value: nil
  ]

  defmacro __using__(fields) do
    fields = @fields ++ fields

    quote do
      defstruct unquote(fields)
    end
  end

  def cmd(event) do
    event
  end
end
