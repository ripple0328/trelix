# CRUSH

## Build & Test

* **Build**: `mix compile`
* **Lint**: `mix credo --all`
* **Run all tests**: `mix test`
* **Run a single test file**: `mix test path/to/file.exs`
* **Run a single test case**: `mix test path/to/file.exs:42` (line number)

## Code Style

* **Formatting**: `mix format --check-formatted`
* **Imports**: keep imports local to modules, avoid wildcard `import Ecto.Query` unless needed.
* **Typing**: use `@type`, `@spec` for public functions; private types with `@typedoc ""`.
* **Naming**: snake_case for functions and variables, PascalCase for modules. Constants in UPPER_CASE.
* **Error handling**: prefer `{:ok, result}` / `{:error, reason}` tuples; use `with` for chaining.
* **Documentation**: module docs with @moduledoc, function docs with @doc. Use `@spec` to document types.
* **Testing**: use `use ExUnit.Case`, group tests with `describe`. Name test cases clearly.

## Cursor / Copilot Rules

* No automatic code generation without review.
* Prefer explicit patterns over `for ... in ... do` unless readability suffers.

---

If you add new commands or style rules, let me know and I’ll update this file.
