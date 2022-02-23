defmodule CommandPaletteWeb.PageController do
  use CommandPaletteWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
