defmodule MastermindWeb.GameLive do
  use MastermindWeb, :live_view

  import MastermindWeb.GameLive.GameComponents

  alias Mastermind.Utils

  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign(:no_steps, 12)
      |> assign(:pins, ["empty", "empty", "empty", "empty"])
      |> assign(:tries, [])
      |> assign(:code, Utils.set_code())

    {:ok, socket}
  end

  def handle_event("play", _value, socket) do
    socket =
      assign(
        socket,
        :tries,
        [
          %{hints: Utils.set_hints(socket.assigns), pins: socket.assigns.pins}
        ] ++ socket.assigns.tries
      )

    socket = assign(socket, :pins, ["empty", "empty", "empty", "empty"])
    {:noreply, socket}
  end

  def handle_event("restart", _value, socket) do
    socket = assign(socket, :code, Utils.set_code())
    socket = assign(socket, :tries, [])
    socket = assign(socket, :pins, ["empty", "empty", "empty", "empty"])
    {:noreply, socket}
  end

  def handle_event("toggle-1-red", _value, socket) do
    {:noreply, assign(socket, :pins, Utils.set_pin(0, "fill-red-500", socket.assigns.pins))}
  end

  def handle_event("toggle-2-red", _value, socket) do
    {:noreply, assign(socket, :pins, Utils.set_pin(1, "fill-red-500", socket.assigns.pins))}
  end

  def handle_event("toggle-3-red", _value, socket) do
    {:noreply, assign(socket, :pins, Utils.set_pin(2, "fill-red-500", socket.assigns.pins))}
  end

  def handle_event("toggle-4-red", _value, socket) do
    {:noreply, assign(socket, :pins, Utils.set_pin(4, "fill-red-500", socket.assigns.pins))}
  end

  def handle_event("toggle-1-blue", _value, socket) do
    {:noreply, assign(socket, :pins, Utils.set_pin(0, "fill-blue-500", socket.assigns.pins))}
  end

  def handle_event("toggle-2-blue", _value, socket) do
    {:noreply, assign(socket, :pins, Utils.set_pin(1, "fill-blue-500", socket.assigns.pins))}
  end

  def handle_event("toggle-3-blue", _value, socket) do
    {:noreply, assign(socket, :pins, Utils.set_pin(2, "fill-blue-500", socket.assigns.pins))}
  end

  def handle_event("toggle-4-blue", _value, socket) do
    {:noreply, assign(socket, :pins, Utils.set_pin(4, "fill-blue-500", socket.assigns.pins))}
  end

  def handle_event("toggle-1-yellow", _value, socket) do
    {:noreply, assign(socket, :pins, Utils.set_pin(0, "fill-yellow-500", socket.assigns.pins))}
  end

  def handle_event("toggle-2-yellow", _value, socket) do
    {:noreply, assign(socket, :pins, Utils.set_pin(1, "fill-yellow-500", socket.assigns.pins))}
  end

  def handle_event("toggle-3-yellow", _value, socket) do
    {:noreply, assign(socket, :pins, Utils.set_pin(2, "fill-yellow-500", socket.assigns.pins))}
  end

  def handle_event("toggle-4-yellow", _value, socket) do
    {:noreply, assign(socket, :pins, Utils.set_pin(4, "fill-yellow-500", socket.assigns.pins))}
  end

  def handle_event("toggle-1-orange", _value, socket) do
    {:noreply, assign(socket, :pins, Utils.set_pin(0, "fill-orange-500", socket.assigns.pins))}
  end

  def handle_event("toggle-2-orange", _value, socket) do
    {:noreply, assign(socket, :pins, Utils.set_pin(1, "fill-orange-500", socket.assigns.pins))}
  end

  def handle_event("toggle-3-orange", _value, socket) do
    {:noreply, assign(socket, :pins, Utils.set_pin(2, "fill-orange-500", socket.assigns.pins))}
  end

  def handle_event("toggle-4-orange", _value, socket) do
    {:noreply, assign(socket, :pins, Utils.set_pin(4, "fill-orange-500", socket.assigns.pins))}
  end

  def handle_event("toggle-1-green", _value, socket) do
    {:noreply, assign(socket, :pins, Utils.set_pin(0, "fill-green-500", socket.assigns.pins))}
  end

  def handle_event("toggle-2-green", _value, socket) do
    {:noreply, assign(socket, :pins, Utils.set_pin(1, "fill-green-500", socket.assigns.pins))}
  end

  def handle_event("toggle-3-green", _value, socket) do
    {:noreply, assign(socket, :pins, Utils.set_pin(2, "fill-green-500", socket.assigns.pins))}
  end

  def handle_event("toggle-4-green", _value, socket) do
    {:noreply, assign(socket, :pins, Utils.set_pin(4, "fill-green-500", socket.assigns.pins))}
  end

  def handle_event("toggle-1-fuchsia", _value, socket) do
    {:noreply, assign(socket, :pins, Utils.set_pin(0, "fill-fuchsia-500", socket.assigns.pins))}
  end

  def handle_event("toggle-2-fuchsia", _value, socket) do
    {:noreply, assign(socket, :pins, Utils.set_pin(1, "fill-fuchsia-500", socket.assigns.pins))}
  end

  def handle_event("toggle-3-fuchsia", _value, socket) do
    {:noreply, assign(socket, :pins, Utils.set_pin(2, "fill-fuchsia-500", socket.assigns.pins))}
  end

  def handle_event("toggle-4-fuchsia", _value, socket) do
    {:noreply, assign(socket, :pins, Utils.set_pin(4, "fill-fuchsia-500", socket.assigns.pins))}
  end

  defp stop(tries, no_steps) do
    Enum.count(tries) == no_steps || (tries != [] && Enum.at(tries, 0).hints == [0, 0, 0, 0])
  end
end
