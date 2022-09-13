defmodule Mastermind.Repo do
  use Ecto.Repo,
    otp_app: :mastermind,
    adapter: Ecto.Adapters.Postgres
end
