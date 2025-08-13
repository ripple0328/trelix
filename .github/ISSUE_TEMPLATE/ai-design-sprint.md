---
name: AI Design Sprint (Tasks 4–8)
about: Run wireflows, ADR, UX copy, acceptance checklist, and LiveView scaffolding with an AI assistant
title: "Design Sprint: New Trip + Sync + UX Copy + Acceptance + LiveView Scaffold"
labels: ["design", "ai", "claude-code", "chatgpt"]
assignees: []
---

> Paste this prompt into Claude Code (or ChatGPT) **and** keep the results in a PR. The assistant should respond with **unified diffs** that only add/modify the mentioned files.

## Master Context
- App: **Trelix** — backpacking & camping trip prep.
- Stack: **Phoenix LiveView** (web), **LiveView Native** (iOS). **Offline-first.** Sync when online.
- Social/sharing from day 1. Trips → members, collaborators, packs, gear items, gear sets.
- **Consumables** per-day/per-meal. **Trail links** (AllTrails) with cached stats. **Weather**.
- Store design artifacts in `DESIGN/` subfolders. Use Markdown + Mermaid. Major choices logged as ADRs.

---

### Task 4) Wireflow — New Trip + AllTrails Link Preview
Create `DESIGN/ux-wireframes/wireflow-new-trip-alltrails.md` using `DESIGN/templates/WIREFLOW_TEMPLATE.md`.

**Include:**
- Assumptions: only store link + cached metadata (ToS-respecting).
- Steps: create trip (name, type, destination, depart location, dates) → paste AllTrails URL → fetch metadata → show preview (trail name, distance, gain, duration, difficulty) → confirm.
- Edge cases: invalid URL, no metadata, offline submission (queue fetch on reconnect).
- Mermaid flow, accessibility & offline, acceptance criteria.

### Task 5) ADR — Offline-first data & sync approach
Create `DESIGN/decisions/adr-0001-offline-first-sync.md`.

**Weigh:**
- ElectricSQL (CRDT) vs custom Ecto sync vs online-first.
- Criteria: complexity, conflict safety, multi-device, LiveView Native support, data volume.
- Make a clear decision, list alternatives & consequences.

### Task 6) UX Copy & Microcopy
Create `DESIGN/ui-copy/strings-core.md`.

**Sections:**
- Trip creation (labels, hints, errors)
- Gear item editor (photo, weight, units, category, description, URL, quantity, worn/starred/consumable)
- Consumable allocation (day picker, meal picker, grams input, remaining)
- Sharing & permissions (viewer/editor/owner)
- Empty states & offline banners  
Style: clear, concise, friendly, outdoor-oriented. Include suggested i18n keys per string.

### Task 7) MVP Acceptance Checklist
Create `DESIGN/checklists/mvp-acceptance.md` with checklists for:
- Trip CRUD + AllTrails preview
- Gear CRUD + sets + overrides
- Itinerary & consumables allocation
- Sharing & roles
- Offline behavior (create/edit offline, conflict resolution, latency compensation)
- Accessibility (labels, focus order, touch targets)

### Task 8) LiveView Scaffolding Brief
Create `DESIGN/handoffs/liveview-scaffold.md` mapping features → screens/components.

**Include:**
- Screens: TripsIndex, TripShow, GearIndex, GearSetEditor, PackAssignment, ItineraryPlanner, MealAllocation
- Components: GearItemForm, GearSetPicker, AllTrailsLinkCard, OfflineBanner, RoleBadge, WeightTotals
- Routes/params, PubSub/Presence touchpoints
- State & assigns plan; error handling; offline fallbacks
- Tailwind notes; testing (Wallaby/Playwright/LiveView tests)

---

## Assistant Instructions
- For **each task**, respond with a **unified diff** creating/updating only the specified files.
- Keep commits **atomic** and include a short rationale in file headers.
- Do **not** change unrelated files.
- If templates in `DESIGN/templates/` are missing, create them first inside the PR.
