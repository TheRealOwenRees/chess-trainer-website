# ChessTrainer

## Starting the development environment

- Run `docker compose up` to run a local Postgres instance
- Run `mix setup` to install and setup dependencies
- Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

[`localhost:4000/endgames`](http://localhost:4000/endgames) is where we are currently focused on.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Static analysis and code checks

We have two tasks that will check your code for code smells, type errors etc.

- `mix credo`
- `mix dialyzer`

## Tests

Test are ran with either

- `mix test`
- `mix test --cover` for a coverage report
