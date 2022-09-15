defmodule MastermindWeb.Game do
  use Surface.LiveView

  alias MastermindWeb.Components.{TogglePin, Pin}

  data pins, :list, default: ["empty", "empty", "empty", "empty"]

  data tries, :list, default: []

  data result, :boolean, default: false

  def render(assigns) do
    ~F"""
    <div class="flex items-center justify-center h-screen">
      <table>
        <thead><tr><th>
              <button type="button" :on-click="try">Try</button></th></tr></thead>
        <tbody>
          <tr>
            <td><TogglePin click="toggle-1-red" /></td>
            <td><TogglePin click="toggle-2-red" /></td>
            <td><TogglePin click="toggle-3-red" /></td>
            <td><TogglePin click="toggle-4-red" /></td>
          </tr>
          <tr>
            <td><TogglePin color="fill-blue-500" click="toggle-1-blue" /></td>
            <td><TogglePin color="fill-blue-500" click="toggle-2-blue" /></td>
            <td><TogglePin color="fill-blue-500" click="toggle-3-blue" /></td>
            <td><TogglePin color="fill-blue-500" click="toggle-4-blue" /></td>
          </tr>
          <tr>
            <td><TogglePin color="fill-yellow-500" click="toggle-1-yellow" /></td>
            <td><TogglePin color="fill-yellow-500" click="toggle-2-yellow" /></td>
            <td><TogglePin color="fill-yellow-500" click="toggle-3-yellow" /></td>
            <td><TogglePin color="fill-yellow-500" click="toggle-4-yellow" /></td>
          </tr>
          <tr>
            <td><TogglePin color="fill-orange-500" click="toggle-1-orange" /></td>
            <td><TogglePin color="fill-orange-500" click="toggle-2-orange" /></td>
            <td><TogglePin color="fill-orange-500" click="toggle-3-orange" /></td>
            <td><TogglePin color="fill-orange-500" click="toggle-4-orange" /></td>
          </tr>
          <tr>
            <td><TogglePin color="fill-green-500" click="toggle-1-green" /></td>
            <td><TogglePin color="fill-green-500" click="toggle-2-green" /></td>
            <td><TogglePin color="fill-green-500" click="toggle-3-green" /></td>
            <td><TogglePin color="fill-green-500" click="toggle-4-green" /></td>
          </tr>
          <tr>
            <td><TogglePin color="fill-fuchsia-500" click="toggle-1-fuchsia" /></td>
            <td><TogglePin color="fill-fuchsia-500" click="toggle-2-fuchsia" /></td>
            <td><TogglePin color="fill-fuchsia-500" click="toggle-3-fuchsia" /></td>
            <td><TogglePin color="fill-fuchsia-500" click="toggle-4-fuchsia" /></td>
          </tr>
          {#for step <- @tries}
            <tr>
              {#for pin <- step.pins}
                <td>
                  <Pin color={pin} />
                </td>
              {/for}
              {#for hint <- step.hints}
                <td>
                  <Pin :if={hint == 0} color="fill-white-500" />
                  <Pin :if={hint == 1} color="fill-black" />
                </td>
              {/for}
            </tr>
          {/for}
          <tr>
            {#for pin <- @pins}
              <td>
                <Pin color={pin} />
              </td>
            {/for}
          </tr>
        </tbody>
      </table>
    </div>
    """
  end

  def mount(_params, _session, socket) do
    socket = assign(socket, :code, set_code())
    socket = assign(socket, :hints, [])
    {:ok, socket}
  end

  def handle_event("try", _value, socket) do
    socket =
      assign(socket, :tries, [
        %{hints: set_hints(socket.assigns), pins: socket.assigns.pins}] ++ socket.assigns.tries
      )

    socket = assign(socket, :pins, ["empty", "empty", "empty", "empty"])
    IO.inspect(socket.assigns.tries)
    {:noreply, socket}
  end

  def handle_event("toggle-1-red", _value, socket) do
    {:noreply, assign(socket, :pins, set_pin(0, "fill-red-500", socket.assigns.pins))}
  end

  def handle_event("toggle-2-red", _value, socket) do
    {:noreply, assign(socket, :pins, set_pin(1, "fill-red-500", socket.assigns.pins))}
  end

  def handle_event("toggle-3-red", _value, socket) do
    {:noreply, assign(socket, :pins, set_pin(2, "fill-red-500", socket.assigns.pins))}
  end

  def handle_event("toggle-4-red", _value, socket) do
    {:noreply, assign(socket, :pins, set_pin(4, "fill-red-500", socket.assigns.pins))}
  end

  def handle_event("toggle-1-blue", _value, socket) do
    {:noreply, assign(socket, :pins, set_pin(0, "fill-blue-500", socket.assigns.pins))}
  end

  def handle_event("toggle-2-blue", _value, socket) do
    {:noreply, assign(socket, :pins, set_pin(1, "fill-blue-500", socket.assigns.pins))}
  end

  def handle_event("toggle-3-blue", _value, socket) do
    {:noreply, assign(socket, :pins, set_pin(2, "fill-blue-500", socket.assigns.pins))}
  end

  def handle_event("toggle-4-blue", _value, socket) do
    {:noreply, assign(socket, :pins, set_pin(4, "fill-blue-500", socket.assigns.pins))}
  end

  def handle_event("toggle-1-yellow", _value, socket) do
    {:noreply, assign(socket, :pins, set_pin(0, "fill-yellow-500", socket.assigns.pins))}
  end

  def handle_event("toggle-2-yellow", _value, socket) do
    {:noreply, assign(socket, :pins, set_pin(1, "fill-yellow-500", socket.assigns.pins))}
  end

  def handle_event("toggle-3-yellow", _value, socket) do
    {:noreply, assign(socket, :pins, set_pin(2, "fill-yellow-500", socket.assigns.pins))}
  end

  def handle_event("toggle-4-yellow", _value, socket) do
    {:noreply, assign(socket, :pins, set_pin(4, "fill-yellow-500", socket.assigns.pins))}
  end

  def handle_event("toggle-1-orange", _value, socket) do
    {:noreply, assign(socket, :pins, set_pin(0, "fill-orange-500", socket.assigns.pins))}
  end

  def handle_event("toggle-2-orange", _value, socket) do
    {:noreply, assign(socket, :pins, set_pin(1, "fill-orange-500", socket.assigns.pins))}
  end

  def handle_event("toggle-3-orange", _value, socket) do
    {:noreply, assign(socket, :pins, set_pin(2, "fill-orange-500", socket.assigns.pins))}
  end

  def handle_event("toggle-4-orange", _value, socket) do
    {:noreply, assign(socket, :pins, set_pin(4, "fill-orange-500", socket.assigns.pins))}
  end

  def handle_event("toggle-1-green", _value, socket) do
    {:noreply, assign(socket, :pins, set_pin(0, "fill-green-500", socket.assigns.pins))}
  end

  def handle_event("toggle-2-green", _value, socket) do
    {:noreply, assign(socket, :pins, set_pin(1, "fill-green-500", socket.assigns.pins))}
  end

  def handle_event("toggle-3-green", _value, socket) do
    {:noreply, assign(socket, :pins, set_pin(2, "fill-green-500", socket.assigns.pins))}
  end

  def handle_event("toggle-4-green", _value, socket) do
    {:noreply, assign(socket, :pins, set_pin(4, "fill-green-500", socket.assigns.pins))}
  end

  def handle_event("toggle-1-fuchsia", _value, socket) do
    {:noreply, assign(socket, :pins, set_pin(0, "fill-fuchsia-500", socket.assigns.pins))}
  end

  def handle_event("toggle-2-fuchsia", _value, socket) do
    {:noreply, assign(socket, :pins, set_pin(1, "fill-fuchsia-500", socket.assigns.pins))}
  end

  def handle_event("toggle-3-fuchsia", _value, socket) do
    {:noreply, assign(socket, :pins, set_pin(2, "fill-fuchsia-500", socket.assigns.pins))}
  end

  def handle_event("toggle-4-fuchsia", _value, socket) do
    {:noreply, assign(socket, :pins, set_pin(4, "fill-fuchsia-500", socket.assigns.pins))}
  end

  defp set_pin(index, color, pins) do
    current =
      if Enum.at(pins, index) == color do
        "empty"
      else
        color
      end

    cond do
      index == 0 -> [current] ++ Enum.slice(pins, 1..3)
      index == 1 -> [Enum.at(pins, 0)] ++ [current] ++ Enum.slice(pins, 2..3)
      index == 2 -> Enum.slice(pins, 0..1) ++ [current] ++ [Enum.at(pins, 3)]
      true -> Enum.slice(pins, 0..2) ++ [current]
    end
  end

  defp set_code() do
    colors = [
      "fill-red-500",
      "fill-blue-500",
      "fill-orange-500",
      "fill-green-500",
      "fill-fuchsia-500",
      "fill-yellow-500"
    ]

    ([Enum.random(colors)] ++
       [Enum.random(colors)] ++ [Enum.random(colors)] ++ [Enum.random(colors)])
    |> IO.inspect()
  end

  defp set_hints(assigns) do
    pins = assigns.pins
    code = assigns.code

    Enum.reduce(0..3, [], fn index, acc ->
      cond do
        Enum.at(pins, index) == Enum.at(code, index) -> [0 | acc]
        Enum.member?(code, Enum.at(pins, index)) -> [1 | acc]
        true -> acc
      end
    end)
  end
end
