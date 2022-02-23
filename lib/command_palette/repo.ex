defmodule CommandPalette.Repo do
  use Ecto.Repo,
    otp_app: :command_palette,
    adapter: Ecto.Adapters.Postgres
end
