# Trelix — Product Roadmap

> **Scope:** Backpacking + Camping only.  
> **Platforms:** Web (Phoenix LiveView), iOS (LiveView Native). Vision Pro/XR planned.  
> **Principles:** Offline‑first • Fast entry • Clear weight math • Seamless sharing • Useful 3D.

## Phase 0 — Discovery
- Personas, competitor review (LighterPack, REI Packing List, AllTrails/Gaia).
- Success metrics and wireframes.

## Phase 1 — MVP (with Social & Sharing)
**Goal:** Collaborative packing on mobile + web with offline.

- Trips (backpacking/camping); **Trip** has destination, depart location, dates, notes, visibility.
- Members & collaborators; roles (owner/editor/viewer), profiles, follow.
- Gear items: photo, weight, unit, category, description, URL, quantity; worn/starred/consumable.
- Packs per trip (main/day/food); totals: base, worn, consumables, per‑category.
- Gear Sets (Travel Sets) attachable to trips with per‑set overrides.
- Offline‑first (local SQLite) + sync; presence for live collaboration.
- Shareable public link (read‑only), invite‑only edit via magic link / social login.

**Milestone:** Group can co‑build and manage a packing list and itinerary offline/online.

## Phase 2 — Planning & Meals
- Itinerary days; meal slots (breakfast/lunch/dinner/snack).
- Consumable batches (e.g., “Oats 500g”, “Fuel can 230g”); allocations per day/meal; remaining auto‑derived.
- Version history, notes/photos per item/trip.
- Gear condition & reminders.

## Phase 3 — Immersive & Trail Preview
- 3D gear viewer (R3F/Three.js); campsite layout visualizer.
- Vision Pro/XR scenes for camp & route walk‑through (RealityKit/Unity).
- Trail link entity (AllTrails) with cached metadata; elevation profile and weather overlays (ToS‑friendly).

## Phase 4 — Premium
- Offline topo maps; GPX import/export.
- AI packing suggestions (trip length, terrain, weather).
- Integrations (Garmin, Apple Health, Strava); freemium + affiliates.

---

## Data Model — v0 (MVP‑ready)

### Core Entities
- **User**: id, name, avatar_url, bio, created_at
- **Trip**: id, owner_id, type (`backpacking`|`camping`), destination, depart_location, start_date, end_date, notes, visibility
- **TripMember**: trip_id, user_id, role; optional personal gear_set
- **GearItem**: id, name, photo_url, weight, weight_unit (`g|kg|oz|lb`), category, description, url, quantity, worn, starred, consumable
- **GearSet**: scenario (`backpacking`|`camping`), description, is_template
- **GearSetItem**: (gear_set_id, gear_item_id) + overrides (quantity/worn/consumable)
- **TripGearSet**: attach sets to trip; pack_role
- **Pack**: per‑trip packs
- **TripItem**: resolved items after sets; quantity, worn, consumable, pack_id, total_weight_grams

### Social
- **Follow**, **TripCollaborator**, **Reaction**, **Comment**

### Trail & Weather
- **TrailLink**: provider (`alltrails`), url, trail_name, distance_km, elevation_gain_m, estimated_duration_h, difficulty, raw_meta
- **WeatherForecast**: per‑day summary + temps, precip, wind, raw_meta

### Itinerary & Meals
- **ItineraryDay**: trip_id, day_index, date, notes
- **ConsumableBatch**: trip_id, gear_item_id, label, grams_total, grams_remaining
- **MealAllocation**: itinerary_day_id, consumable_batch_id, meal (`breakfast|lunch|dinner|snack`), grams, user_id (optional)

### Acceptance (MVP)
- Create/edit *GearItem* with full fields incl. worn/starred/consumable.
- Create *GearSet*, attach to *Trip*, see correct totals (base/worn/consumables).
- Add *ItineraryDay* and allocate consumables per day/meal; track remaining.
- Share trip via link; collaborators can view/edit per role.
- Works offline; syncs when back online.
