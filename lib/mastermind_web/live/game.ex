defmodule MastermindWeb.Game do
  use Surface.LiveView

  alias MastermindWeb.Components.{TogglePin, Pin, Play, Restart}
  alias Mastermind.Utils

  data pins, :list, default: ["empty", "empty", "empty", "empty"]

  data tries, :list, default: []

  data no_steps, :integer, default: 12

  def render(assigns) do
    ~F"""
    <div class="flex items-center justify-center">
      <table>
        <thead><tr><th>
              <Play :if={not stop(@tries, @no_steps)} click="play" />
              <Restart :if={stop(@tries, @no_steps)} click="restart" /></th>
            <th :if={stop(@tries, @no_steps)}>C O D E</th></tr>
        </thead>
        <tbody><tr :if={stop(@tries, @no_steps)}>
            {#for code <- @code}
              <td>
                <Pin color={code} />
              </td>
            {/for}
          </tr>
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
              <td>
                <Pin :if={Enum.at(step.hints, 0) == 0} size="w-6 w-6" color="fill-white-500" />
                <Pin :if={Enum.at(step.hints, 0) == 1} size="w-6 w-6" color="fill-black" />
                <Pin :if={Enum.at(step.hints, 0) == 2} size="w-6 w-6" color="fill-red-500" />
                <Pin :if={Enum.at(step.hints, 1) == 0} size="w-6 w-6" color="fill-white-500" />
                <Pin :if={Enum.at(step.hints, 1) == 1} size="w-6 w-6" color="fill-black" />
                <Pin :if={Enum.at(step.hints, 1) == 2} size="w-6 w-6" color="fill-red-500" />
              </td>
              <td>
                <Pin :if={Enum.at(step.hints, 2) == 0} size="w-6 w-6" color="fill-white-500" />
                <Pin :if={Enum.at(step.hints, 2) == 1} size="w-6 w-6" color="fill-black" />
                <Pin :if={Enum.at(step.hints, 2) == 2} size="w-6 w-6" color="fill-red-500" />
                <Pin :if={Enum.at(step.hints, 3) == 0} size="w-6 w-6" color="fill-white-500" />
                <Pin :if={Enum.at(step.hints, 3) == 1} size="w-6 w-6" color="fill-black" />
                <Pin :if={Enum.at(step.hints, 3) == 2} size="w-6 w-6" color="fill-red-500" />
              </td>
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
    socket = assign(socket, :code, Utils.set_code())
    socket = assign(socket, :tries, [])
    {:ok, socket}
  end

  def handle_event("play", _value, socket) do
    socket =
      assign(
        socket,
        :tries,
        socket.assigns.tries ++
          [
            %{hints: Utils.set_hints(socket.assigns), pins: socket.assigns.pins}
          ]
      )

    socket = assign(socket, :pins, ["empty", "empty", "empty", "empty"])
    IO.inspect(socket.assigns.tries)
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
    Enum.count(tries) == no_steps || (tries != [] && Enum.at(tries, -1).hints == [0, 0, 0, 0])
  end
end
