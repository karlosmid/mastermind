defmodule MastermindWeb.Components.TogglePin do
  @moduledoc """
  Toggle Pin component. We have six colours.
  """
  use Surface.Component

  prop(click, :event, required: true)
  prop(color, :string, default: "fill-red-500")

  def render(assigns) do
    ~F"""
    <svg
      xmlns="http://www.w3.org/2000/svg"
      fill="none"
      viewBox="0 0 24 24"
      stroke-width="1.5"
      stroke="currentColor"
      class={"w-12 h-12", @color}
      :on-click={@click}
    >
      <path
        stroke-linecap="round"
        stroke-linejoin="round"
        d="M12 9v6m3-3H9m12 0a9 9 0 11-18 0 9 9 0 0118 0z"
      />
    </svg>
    """
  end
end
