development:
	source .env && iex -S mix phx.server
setup:
	source .env && mix ecto.setup
migrate:
	source .env && mix ecto.migrate