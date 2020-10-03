defmodule Ex21.Repo do
  use Ecto.Repo,
    otp_app: :ex_21,
    adapter: Ecto.Adapters.Postgres
end
