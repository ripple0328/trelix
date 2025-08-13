# Trelix Design Workspace

## Purpose

The DESIGN/ folder contains all product design artifacts, specifications, and decisions for Trelix. This workspace ensures consistent, reviewable design deliverables that serve as the Single Source of Truth for product direction.

## Structure

- `product-specs/` - Product requirements and feature specifications
- `ux-wireframes/` - User experience flows and wireframes
- `ui-designs/` - Visual designs and interface mockups
- `architecture/` - System design and technical architecture
- `adrs/` - Architectural Decision Records
- `templates/` - Standard templates for design artifacts

## Design Request Process

### 1. Create GitHub Issue
Use GitHub Issues with the `design` label to request design work:
- **Product Specs**: Use `[PRD]` prefix for new features
- **Wireflows**: Use `[UX]` prefix for user experience design
- **Architecture**: Use `[ARCH]` prefix for technical decisions

### 2. Design Phase
- Use appropriate template from `templates/`
- Save deliverables in correct subdirectory
- Include rationale, constraints, and acceptance criteria
- Use Mermaid for flows where possible

### 3. Review Gates
Before coding begins:
- [ ] Design artifact exists in DESIGN/
- [ ] Acceptance criteria are clear and testable
- [ ] Technical feasibility confirmed
- [ ] Stakeholder sign-off on GitHub Issue

## Templates

- [`PRD_TEMPLATE.md`](templates/PRD_TEMPLATE.md) - Product Requirements Document
- [`WIREFLOW_TEMPLATE.md`](templates/WIREFLOW_TEMPLATE.md) - UX Wireflows and Flows
- [`ADR_TEMPLATE.md`](templates/ADR_TEMPLATE.md) - Architectural Decision Records

## Guidelines

- Keep artifacts short and reviewable
- Propose changes as unified diffs
- Maintain consistency with ROADMAP.md
- Document major decisions as ADRs
- Use mobile-first approach for all UX design