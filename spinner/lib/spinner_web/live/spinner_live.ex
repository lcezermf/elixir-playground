defmodule SpinnerWeb.SpinnerLive do
  use SpinnerWeb, :live_view

  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign(:posts, [])
      |> assign(:loading, false)

    {:ok, socket}
  end

  def handle_event("load-posts", _params, socket) do
    socket = assign(socket, :loading, true)

    send(self(), :load_posts)

    {:noreply, socket}
  end

  def handle_info(:load_posts, socket) do
    # Just to emulate the long time request
    :timer.sleep(2000)

    socket =
      socket
      |> assign(:posts, get_posts())
      |> assign(:loading, false)

    {:noreply, socket}
  end

  defp get_posts do
    [
      %Spinner.Post{title: "First Title", description: "First Description"},
      %Spinner.Post{title: "Second Title", description: "Second Description"}
    ]
  end
end
