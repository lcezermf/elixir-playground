defmodule Servy.SensorServer do

  @name :sensor_server

  use GenServer

  # Client Interface

  defmodule State do
    defstruct sensor_data: %{},
              refresh_interval: :timer.seconds(5)
  end

  def start_link(interval) do
    IO.puts "Starting #{__MODULE__} with #{interval}"
    GenServer.start_link(__MODULE__, %State{refresh_interval: :timer.seconds(interval)}, name: @name)
  end

  def get_sensor_data do
    GenServer.call @name, :get_sensor_data
  end

  def set_refresh_interval(interval) do
    GenServer.cast(@name, {:set_refresh_interval, interval})
  end

  # Server Callbacks

  def init(state) do
    sensor_data = run_tasks_to_get_sensor_data()
    initial_state = %{state | sensor_data: sensor_data}
    schedule_refresh(state.refresh_interval)
    {:ok, initial_state}
  end

  def handle_call(:get_sensor_data, _from, state) do
    {:reply, state.sensor_data, state}
  end

  def handle_cast({:set_refresh_interval, interval}, state) do
    new_state = %{state | refresh_interval: interval}

    {:noreply, new_state}
  end

  def handle_info(:refresh, state) do
    IO.puts "Refreshing the cache... #{state.refresh_interval}"
    sensor_data = run_tasks_to_get_sensor_data()
    new_state = %{state | sensor_data: sensor_data}

    schedule_refresh(state.refresh_interval)

    {:noreply, new_state}
  end

  defp schedule_refresh(refresh_interval) do
    Process.send_after(self(), :refresh, refresh_interval)
  end

  defp run_tasks_to_get_sensor_data do
    IO.puts "Running tasks to get sensor data..."

    task = Task.async(fn -> Servy.Tracker.get_location("bigfoot") end)

    snapshots =
      ["cam-1", "cam-2", "cam-3"]
      |> Enum.map(&Task.async(fn -> Servy.VideoCam.get_snapshot(&1) end))
      |> Enum.map(&Task.await/1)

    where_is_bigfoot = Task.await(task)

    %{snapshots: snapshots, location: where_is_bigfoot}
  end
end
