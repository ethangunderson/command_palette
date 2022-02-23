defmodule CommandPalette.Components.CommandPalette do
  use Phoenix.LiveComponent

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
               @keydown.arrow-down.prevent="currentPosition++"
               @keydown.arrow-up.prevent="currentPosition--"
               placeholder="Search..." 
               class="text-2xl w-full focus:outline-none"/>
          </div>
        <ul class="max-h-72 overflow-y-auto py-2 text-gray-800">
          <template x-for="(key, index) in ['result 1', 'result 2', 'result 3', 'result 4']" :key="index">
            <li x-text="key" 
              :class="{ 'bg-gray-200': index === currentPosition }"
              class="select-none px-4 py-2 hover:bg-gray-200 hover:cursor-pointer"></li>
          </template>
        </ul>
      </div>
    </div> 
    """
  end
end
