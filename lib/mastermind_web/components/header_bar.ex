defmodule MastermindWeb.HeaderBar do
  use MastermindWeb, :live_component

  def render(assigns) do
    ~H"""
    <header class="bg-neutral-900">
      <section class="container mx-auto">
        <nav class="flex items-center justify-between flex-wrap p-6">
          <div class="flex items-center flex-shrink-0 text-white mr-6">
            <a href="/" class="font-semibold text-xl tracking-tight">Mastermind</a>
          </div>
          <div class="w-full block flex-grow md:flex md:items-center md:w-auto">
            <div>
              <a
                href="https://en.wikipedia.org/wiki/Mastermind_(board_game)"
                class="inline-block text-sm px-4 py-2 leading-none border rounded text-white border-white hover:border-transparent hover:text-teal-500 hover:bg-white mt-4 lg:mt-0"
              >
                Rules
              </a>
            </div>
          </div>
        </nav>
      </section>
    </header>
    """
  end
end
