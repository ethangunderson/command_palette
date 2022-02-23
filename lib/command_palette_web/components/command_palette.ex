defmodule CommandPalette.Components.CommandPalette do
  use Phoenix.LiveComponent

  def mount(socket) do
    {:ok, assign(socket, :results, ["No results"] |> Jason.encode!())}
  end

  def render(assigns) do
    ~H"""
      <div 
      x-data="{ open: false, currentPosition: 0 }" 
      x-show="open"
      @keydown.meta.k.window.prevent="open = !open"
      @keydown.escape.window="open = false"
      class="fixed inset-0 top-0 z-10 pt-[25vh]"> 
      <div class="fixed inset-0 bg-gray-500/75 opacity-90"></div>
        <div @click.outside="open = false" class="overflow-y-auto relative rounded-xl shadow-2xl max-w-xl mx-auto p-4 bg-white opacity-100 ring-1 ring-black/5">
          <div class="border-b-2 pb-4">
            <input 
               x-trap="open"
               x-on:keydown.arrow-down.prevent="currentPosition++"
               x-on:keydown.arrow-up.prevent="currentPosition--"
               phx-keyup="typetype"
               phx-target={@myself}
               phx-debounce="200"
               placeholder="Search..." 
               class="text-2xl w-full focus:outline-none"/>
          </div>
        <ul class="max-h-72 overflow-y-auto py-2 text-gray-800">
    <template x-for={"(key, index) in #{@results}"} :key="index">
            <li x-text="key"
              :class="{ 'bg-gray-200': index === currentPosition }"
              class="select-none px-4 py-2 hover:bg-gray-200 hover:cursor-pointer">
            </li>
          </template>
        </ul>
      </div>
    </div> 
    """
  end

  def result_list(assigns) do
    ~H"""
      <%= for result <- @results do %>
        <li>
          <%= IO.inspect(result) %>
        </li>
      <% end %>
    """
  end

  def handle_event("typetype", %{"value" => ""}, socket) do
    {:noreply, assign(socket, :results, ["No results"] |> Jason.encode!())}
  end

  def handle_event("typetype", %{"value" => search_string}, socket) do
    possible_results = [
      "Result 1",
      "Result 2",
      "Result 3",
      "Result 4",
      "Result 5",
      "Result 6",
      "Result a",
      "Result b",
      "Result c",
      "Result d"
    ]

    results =
      Enum.filter(possible_results, fn result -> String.contains?(result, search_string) end)
      |> Jason.encode!()

    socket =
      socket
      |> assign(:results, results)

    {:noreply, socket}
  end
end
