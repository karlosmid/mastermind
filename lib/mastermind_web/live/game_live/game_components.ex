defmodule MastermindWeb.GameLive.GameComponents do
  use MastermindWeb, :live_component

  def play(assigns) do
    ~H"""
    <button class="cursor-pointer hover:scale-110" phx-click="play">
      <.icon name="hero-play-solid" class="w-12 h-12 text-teal-500" />
    </button>
    """
  end

  def restart(assigns) do
    ~H"""
    <button class="cursor-pointer hover:scale-110" phx-click="restart">
      <.icon name="hero-arrow-path" class="w-10 h-10 text-rose-500" />
    </button>
    """
  end

  attr :color, :string, required: true
  attr :selected, :boolean, default: false

  def color_pin(assigns) do
    color_class =
      case assigns.color do
        :red -> "text-red-500"
        :blue -> "text-blue-500"
        :yellow -> "text-yellow-500"
        :orange -> "text-orange-500"
        :green -> "text-green-500"
        :fuchsia -> "text-fuchsia-500"
      end

    assigns = assign(assigns, :color_class, color_class)

    ~H"""
    <button
      phx-click="select_color"
      phx-value-color={@color}
      class={[
        "cursor-pointer hover:scale-110 rounded-full",
        if(@selected, do: "border-2 border-red-700")
      ]}
    >
      <.icon
        name="hero-plus-circle-solid"
        class={
          [
            "w-14 h-14",
            @color_class
          ]
          |> Enum.join(" ")
        }
      />
    </button>
    """
  end

  attr :size, :string, default: "w-12 h-12"
  attr :color, :atom, default: :empty
  attr :active?, :boolean, default: false
  attr :rest, :global, include: ~w(phx-click phx-value-index)

  def pin(assigns) do
    color_class =
      case assigns.color do
        :red -> "fill-red-500"
        :blue -> "fill-blue-500"
        :yellow -> "fill-yellow-500"
        :orange -> "fill-orange-500"
        :green -> "fill-green-500"
        :fuchsia -> "fill-fuchsia-500"
        :black -> "fill-black"
        :white -> "fill-white-500"
        :empty -> "fill-white-500"
        nil -> "fill-white-500"
      end

    assigns = assign(assigns, :color_class, color_class)

    ~H"""
    <svg
      xmlns="http://www.w3.org/2000/svg"
      fill="none"
      viewBox="0 0 24 24"
      stroke-width="1.5"
      stroke="currentColor"
      class={[
        if(@active?, do: "cursor-pointer hover:scale-110"),
        @size,
        @color_class
      ]}
      {@rest}
    >
      <path
        stroke-linecap="round"
        stroke-linejoin="round"
        d="M5.25 7.5A2.25 2.25 0 017.5 5.25h9a2.25 2.25 0 012.25 2.25v9a2.25 2.25 0 01-2.25 2.25h-9a2.25 2.25 0 01-2.25-2.25v-9z"
      />
    </svg>
    """
  end
end
