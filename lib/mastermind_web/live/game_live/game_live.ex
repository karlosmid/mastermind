defmodule MastermindWeb.GameLive do
  use MastermindWeb, :live_view

  import MastermindWeb.GameLive.GameComponents

  alias Mastermind.Utils

  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign(:no_steps, 12)
      |> assign(:colors, Utils.colors())
      |> assign(:selected_color, nil)
      |> assign_empty_pins()
      |> assign(:tries, [])
      |> assign(:code, Utils.set_code())

    {:ok, socket}
  end

  defp assign_empty_pins(socket) do
    pins = Enum.map(1..4, fn _ -> :empty end)
    assign(socket, :pins, pins)
  end

  def handle_event("play", _value, %{assigns: %{pins: pins, tries: tries}} = socket) do
    tries = [%{hints: Utils.set_hints(socket.assigns), pins: pins} | tries]

    socket =
      socket
      |> assign(:tries, tries)
      |> assign_empty_pins()

    {:noreply, socket}
  end

  def handle_event("restart", _value, socket) do
    socket =
      socket
      |> assign(:code, Utils.set_code())
      |> assign(:tries, [])
      |> assign(:selected_color, nil)
      |> assign_empty_pins()

    {:noreply, socket}
  end

  def handle_event(
        "select_color",
        %{"color" => color},
        %{assigns: %{selected_color: selected_color}} = socket
      ) do
    color = String.to_existing_atom(color)
    selected_color = if color == selected_color, do: nil, else: color
    socket = assign(socket, :selected_color, selected_color)
    {:noreply, socket}
  end

  def handle_event(
        "toggle_pin",
        %{"index" => index},
        %{assigns: %{pins: pins, selected_color: selected_color}} = socket
      ) do
    index = String.to_integer(index)
    pins = Utils.set_pin(index, selected_color, pins)
    socket = assign(socket, :pins, pins)
    {:noreply, socket}
  end

  defp stop(tries, no_steps) do
    Enum.count(tries) == no_steps || (tries != [] && Enum.at(tries, 0).hints == [0, 0, 0, 0])
  end
end
