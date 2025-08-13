defmodule Trelix.Repo do
  use Ecto.Repo,
    otp_app: :trelix,
    adapter: Ecto.Adapters.Postgres
end
