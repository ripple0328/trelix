# Trelix

**Trelix** is a mobile‑first (Phoenix LiveView + LiveView Native iOS) app for **backpacking & camping trip prep** —
collaborative packing lists, per‑day **consumable** planning, social sharing, and optional 3D/VR previews.

## Highlights
- **Offline‑first** with local SQLite; **sync when online**.
- **Social & sharing** from day one (profiles, follow, trip collaborators).
- **Gear items** with photo, weight (units), category, description, URL, quantity, and booleans: worn/starred/consumable.
- **Gear Sets / Travel Sets** for scenarios (Backpacking, Camping); attach to trips.
- **Itinerary & meals**: allocate consumables by day/meal (breakfast/lunch/dinner/snack).
- **Trail previews**: store a link to AllTrails and cache metadata for planning (respecting their ToS).
- **Vision Pro / XR** roadmap for immersive gear & terrain previews.

## Stack
- **Web:** Phoenix + LiveView
- **iOS:** LiveView Native (Swift) where feasible
- **Data:** Postgres (server) + SQLite (client); optional ElectricSQL for CRDT sync
- **Domain:** Ash Framework + AshPostgres

## Getting Started
1. Create a new GitHub repo (e.g., `trelix`) and upload this content (or unzip and `git init`).
2. In Phoenix:
   - Add deps: `{:ash, "~> 3.0"}, {:ash_postgres, "~> 2.0"}, {:ecto_sql, "~> 3.11"}, {:postgrex, ">= 0.0.0"}`
   - Configure `Trelix.Repo` and `ash_domains: [Trelix.Domain]`
   - Run `mix ash_postgres.generate_migrations` then `mix ecto.migrate`
3. Build LiveView screens for Trips, Gear, Sets, Itinerary/Meals, and Allocations.
4. (Optional) Wire ElectricSQL or your custom sync strategy.

## License
MIT
