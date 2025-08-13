# New Trip + AllTrails Link Preview - Wireflow Design

**Status**: Draft  
**Designer**: Product Team  
**Date**: 2025-08-13  
**Related PRD**: DESIGN/product-specs/prd-consumables-per-day-meal.md  
**Related Issue**: #[TBD]

## Feature Overview

Users can create new trips and optionally link AllTrails content for trail metadata. The system fetches and caches trail information while respecting ToS, providing rich context for trip planning without requiring users to manually enter trail details.

## Assumptions

- AllTrails links are stored as URLs with cached metadata only (ToS-respecting)
- Metadata includes: trail name, distance, elevation gain, estimated duration, difficulty rating
- Offline submissions queue metadata fetch for when connectivity returns
- Link validation happens client-side for immediate feedback
- Cached metadata has TTL and can be refreshed

## Mobile-First User Flow

```mermaid
flowchart TD
    A[Trips Index] --> B[Tap "New Trip"]
    B --> C[Trip Creation Form]
    C --> D[Fill Basic Info]
    D --> E{Add AllTrails Link?}
    E -->|No| F[Save Trip]
    E -->|Yes| G[Paste AllTrails URL]
    G --> H{Valid URL?}
    H -->|No| I[Show URL Error]
    I --> G
    H -->|Yes| J{Online?}
    J -->|No| K[Queue for Later]
    J -->|Yes| L[Fetch Metadata]
    L --> M{Metadata Found?}
    M -->|No| N[Show No Data Available]
    M -->|Yes| O[Show Trail Preview]
    O --> P{Confirm Link?}
    P -->|No| Q[Remove Link]
    P -->|Yes| R[Save Trip with Link]
    F --> S[Trip Detail View]
    K --> S
    R --> S
    Q --> F
    N --> T{Save Anyway?}
    T -->|Yes| F
    T -->|No| G
    
    %% Error flows
    L -.->|Network Error| U[Show Retry Option]
    U --> L
    U --> K
```

## Screen Inventory

### Screen 1: Trip Creation Form
**Purpose**: Collect basic trip information and optional AllTrails link  
**Layout**: Vertical form with clear sections for required and optional fields

**Key Elements**:
- Trip Name: Text input (required)
- Trip Type: Picker (Backpacking, Day Hike, Car Camping, etc.)
- Destination: Text input with location suggestions
- Departure Location: Text input (optional)
- Start Date: Date picker
- End Date: Date picker  
- AllTrails URL: Text input with paste helper (optional)
- Create Trip: Primary CTA button

**States**:
- Loading: Form disabled, spinner on submit
- Error: Field-specific error messages below inputs
- Empty: Placeholder text guides user input

---

### Screen 2: AllTrails Link Preview
**Purpose**: Display fetched trail metadata for user confirmation  
**Layout**: Card-based preview with trail details and confirmation actions

**Key Elements**:
- Trail thumbnail image (if available)
- Trail name and location
- Distance, elevation gain, estimated time
- Difficulty rating with visual indicator
- "Use This Trail" and "Remove Link" buttons
- Loading state while fetching

**States**:
- Loading: Skeleton loader for metadata
- Success: Full trail card with data
- Error: Fallback message with retry option
- No Data: Graceful message about manual entry

---

### Screen 3: Error States
**Purpose**: Handle various failure scenarios gracefully  
**Layout**: Centered message with clear recovery actions

**Key Error Types**:
- Invalid URL format
- Network connectivity issues
- AllTrails content not accessible
- Rate limiting or service unavailable

## Visual Assets

### Wireframes
- [ ] `wireframe-new-trip-form.png` - Basic trip creation form
- [ ] `wireframe-alltrails-preview.png` - Trail metadata preview card
- [ ] `wireframe-error-states.png` - Error handling screens

### Exported Designs
- [ ] `design-new-trip-flow.png` - Complete flow design
- [ ] `prototype-alltrails-integration.mp4` - Interactive prototype

## Edge Cases & Offline Behavior

### Offline States
- **No Connection**: Queue AllTrails fetch for later, allow trip creation
- **Sync Conflict**: Merge trip data with server, re-attempt metadata fetch
- **Partial Data**: Save trip with URL but without metadata preview

### Error States
- **Invalid URL**: Client-side validation with helpful format examples
- **Fetch Failure**: Retry mechanism with exponential backoff
- **Rate Limited**: Clear message about temporary unavailability

### Edge Cases
- **Empty Metadata**: Allow manual trail name entry as fallback
- **Stale Cache**: Refresh metadata option in trip details
- **URL Changes**: Handle AllTrails URL format changes gracefully

## Accessibility Notes

### Screen Reader Support
- Form labels clearly associated with inputs
- Error messages announced when they appear
- Trail preview card has descriptive heading structure
- Loading states communicated to assistive technology

### Keyboard Navigation
- Tab order: Name → Type → Destination → Dates → URL → Submit
- Enter key submits form from any field
- Escape key cancels operations and shows confirmation

### Visual Accessibility
- High contrast for form validation states
- Sufficient touch targets (44px minimum)
- Clear visual hierarchy with proper spacing
- Error states use color + icon + text

## Platform Considerations

### LiveView Web
- Real-time form validation with live feedback
- Responsive design for desktop/tablet trip planning
- URL paste detection for enhanced UX

### LiveView Native iOS
- Native date picker integration
- Paste menu integration for AllTrails URLs
- Haptic feedback for form submission and errors

## Acceptance Criteria

### Functional
- [ ] User can create trip with all required fields
- [ ] AllTrails URL validation works for common formats
- [ ] Trail metadata fetches and displays correctly
- [ ] Offline trip creation queues metadata fetch
- [ ] Error states provide clear recovery paths
- [ ] Form persists data during navigation interruptions

### Visual
- [ ] Form follows Trelix design system
- [ ] Trail preview card matches mockups
- [ ] Loading states provide appropriate feedback
- [ ] Error messages are contextual and helpful

### Technical
- [ ] Form validation prevents invalid submissions
- [ ] AllTrails API calls respect rate limits
- [ ] Metadata caching reduces redundant requests
- [ ] Offline capability maintains data integrity
- [ ] Performance meets 2-second load targets

### Accessibility
- [ ] Screen reader navigation is logical and complete
- [ ] All interactive elements are keyboard accessible
- [ ] Form errors are announced and associated properly
- [ ] Color contrast meets WCAG 2.1 AA standards

---

**Implementation Notes**: AllTrails metadata should be cached with reasonable TTL. Consider implementing client-side URL pattern detection to pre-validate before submission.  
**Next Steps**: Create detailed designs for trail preview card component and error state variations.