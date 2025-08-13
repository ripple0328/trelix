# Ash Resources (Trelix)

Add these to your Phoenix app:
- Configure `Trelix.Repo` and `ash_domains: [Trelix.Domain]`
- Run `mix ash_postgres.generate_migrations` then `mix ecto.migrate`

These resources include:
- Trips, members, collaborators, packs
- Gear items, gear sets, join with overrides, trip items
- Trail links, weather
- Itinerary days, consumable batches, meal allocations
- Social graph, reactions, comments
