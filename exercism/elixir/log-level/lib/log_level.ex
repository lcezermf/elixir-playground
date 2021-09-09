defmodule LogLevel do
  @spec to_label(any, any) :: :debug | :error | :fatal | :info | :trace | :unknown | :warning
  def to_label(level, legacy?) do
    do_to_label(level, legacy?)
  end

  @spec alert_recipient(any, any) :: :dev1 | :dev2 | nil | :ops
  def alert_recipient(level, legacy?) do
    result = do_to_label(level, legacy?)

    cond do
      Enum.member?([:error, :fatal], result) -> :ops
      result == :unknown && legacy? -> :dev1
      result == :unknown -> :dev2
      true -> nil
    end
  end

  defp do_to_label(level, legacy?) do
    cond do
      level == 0 and !legacy? -> :trace
      level == 1 -> :debug
      level == 2 -> :info
      level == 3 -> :warning
      level == 4 -> :error
      level == 5 and !legacy? -> :fatal
      true -> :unknown
    end
  end
end
