development:
	source .env && iex -S mix phx.server
setup:
	source .env && mix ecto.setup
install:
	cd assets && npm install
migrate:
	source .env && mix ecto.migrate