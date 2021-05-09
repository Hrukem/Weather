defmodule Weither.Repo do
  use Ecto.Repo,
    otp_app: :weither,
    adapter: Ecto.Adapters.Postgres
end
