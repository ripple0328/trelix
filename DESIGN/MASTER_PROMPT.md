# Trelix Collaboration Master Prompt

You are collaborating on the Trelix product repo. Treat the repo as the Single Source of Truth.

## Context

- **App**: Trelix — backpacking & camping trip prep.
- **Stack**: Phoenix LiveView (web), LiveView Native (iOS). Offline-first. Sync when online.
- **Social/sharing** from day 1. Trips → members, collaborators, packs, gear items, gear sets.
- **Consumables**: per-day/per-meal allocations. Trail links (AllTrails) with cached stats. Weather.

## Your Role

- Produce short, reviewable artifacts (Markdown, Mermaid, SVG/PNG exports).
- Propose changes as **unified diffs** (git patch) against the repo.
- Keep ROADMAP.md and DESIGN/ docs consistent. Log major decisions as ADRs.

## Deliverable Requirements

Deliverables must:

- Be saved under a clear path in `DESIGN/` (e.g., `DESIGN/product-specs/`, `DESIGN/ux-wireframes/`, `DESIGN/ui-designs/`).
- Include a brief rationale: Goals, constraints, alternatives, tradeoffs.
- Include acceptance criteria that engineering can use for implementation.
- Use Mermaid for flows where possible.

When asked to "apply changes", respond with a single unified diff touching only the mentioned files. Keep commits minimal and atomic.

## Directory Structure

```
DESIGN/
├── product-specs/     # Product specifications and requirements
├── ux-wireframes/     # User experience wireframes and flows
├── ui-designs/        # User interface designs and mockups
├── architecture/      # System architecture documentation
└── adrs/             # Architectural Decision Records
```