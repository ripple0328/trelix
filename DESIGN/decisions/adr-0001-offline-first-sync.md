# ADR-0001: Offline-First Data Synchronization Strategy

**Status**: Proposed  
**Date**: 2025-08-13  
**Deciders**: Technical Team, Product Team  
**Technical Story**: Core offline-first architecture for Trelix

## Context

Trelix is designed as an offline-first application for backpacking trip preparation. Users need to plan trips, manage gear, and collaborate on itineraries while having intermittent or no internet connectivity. The application must work seamlessly offline and synchronize changes when connectivity is restored, supporting collaborative editing across multiple users and devices.

### Problem Statement
How should we implement offline-first data synchronization that handles:
- Local-first data storage and manipulation
- Conflict-free collaborative editing
- Cross-platform support (Phoenix LiveView web + LiveView Native iOS)
- Real-time updates when online
- Data integrity and consistency

### Constraints
- Must support Phoenix LiveView architecture
- LiveView Native iOS compatibility required
- Multi-user collaborative editing essential
- Limited development resources for complex sync implementations
- Data volume will be moderate (thousands of records per user, not millions)

## Decision

We will implement a **custom Ecto-based synchronization layer** with conflict resolution rules rather than adopting ElectricSQL.

### Implementation Details
- **Local Storage**: SQLite for iOS native, IndexedDB for web clients
- **Server**: PostgreSQL with Ecto changesets for data validation
- **Sync Protocol**: Custom REST API with vector clocks for conflict detection
- **Conflict Resolution**: Last-writer-wins with manual resolution for critical conflicts
- **Real-time**: Phoenix PubSub for live updates when online
- **Optimistic Updates**: Immediate local updates with server reconciliation

## Alternatives Considered

### Option 1: ElectricSQL (CRDT-based sync)
**Pros**: 
- Automatic conflict-free merging with CRDTs
- Built-in PostgreSQL ⇄ SQLite synchronization
- Mature conflict resolution algorithms
- Strong consistency guarantees

**Cons**:
- Complex integration with Phoenix LiveView
- Limited LiveView Native support/documentation
- Learning curve for CRDT concepts
- Potential over-engineering for our data complexity
- Additional infrastructure complexity

**Why rejected**: Integration complexity with LiveView ecosystem outweighs CRDT benefits for our use case

---

### Option 2: Online-First with Optimistic UI
**Pros**: 
- Simpler implementation
- Native LiveView patterns
- Immediate consistency feedback
- Lower complexity

**Cons**:
- Poor offline experience (core requirement)
- Requires constant connectivity
- Conflicts with outdoor use case
- Limited collaborative editing capability

**Why rejected**: Violates core offline-first requirement for outdoor users

## Consequences

### Positive
- Full control over sync logic and conflict resolution
- Native integration with Phoenix LiveView patterns
- Customizable to Trelix-specific data models
- Enables sophisticated offline collaboration features
- Lower operational complexity than ElectricSQL

### Negative
- Custom sync implementation requires more development time
- Manual conflict resolution may require user intervention
- Need to implement vector clocks and sync protocol
- More testing required for edge cases
- Potential for sync bugs during development

### Neutral
- Moderate implementation complexity
- Team needs to learn sync pattern concepts
- Ongoing maintenance of sync logic

## Implementation Plan

### Phase 1: Core Offline Storage (Week 1-2)
- [ ] Implement SQLite adapter for LiveView Native
- [ ] Add IndexedDB wrapper for web clients
- [ ] Create local data models mirroring server schema
- [ ] Basic CRUD operations working offline

### Phase 2: Sync Protocol (Week 3-4)
- [ ] Design sync API endpoints
- [ ] Implement vector clock-based change tracking
- [ ] Add conflict detection and resolution logic
- [ ] Basic sync working for single user

### Phase 3: Collaborative Sync (Week 5-6)
- [ ] Multi-user conflict resolution
- [ ] Real-time updates via PubSub
- [ ] Manual conflict resolution UI
- [ ] Testing with multiple concurrent users

### Success Criteria
- 99% of offline changes sync successfully without data loss
- Conflict resolution handles 95% of cases automatically
- Sync completes within 5 seconds for typical trip data
- Support for 10+ concurrent collaborators per trip

## Monitoring & Review

### Metrics to Track
- Sync success rate and failure modes
- Conflict frequency and resolution methods
- Offline usage patterns and duration
- Performance impact of sync operations

### Review Schedule
- **Next Review**: 2025-10-13 (after Phase 2 completion)
- **Review Trigger**: If sync failures exceed 5% or performance degrades significantly

## Links

### Related Decisions
- [ADR-XXX]: Phoenix LiveView architecture (future)
- [ADR-XXX]: Data modeling and schema design (future)

### References
- [Vector Clocks for Conflict Detection](https://en.wikipedia.org/wiki/Vector_clock)
- [Phoenix PubSub Documentation](https://hexdocs.pm/phoenix_pubsub/)
- [LiveView Native Data Patterns](https://hexdocs.pm/live_view_native/)

### Implementation
- [Implementation Epic]: #[TBD]
- [Sync Protocol Specification]: DESIGN/architecture/sync-protocol.md (future)
- [Conflict Resolution UX]: DESIGN/ux-wireframes/conflict-resolution.md (future)

---

**Superseded by**: [None]  
**Supersedes**: [None]