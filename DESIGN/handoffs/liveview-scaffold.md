# LiveView Scaffolding Implementation Brief

**Purpose**: Technical implementation guide for Phoenix LiveView architecture  
**Target**: Engineering team for MVP development  
**Updated**: 2025-08-13

## Screen Architecture

### Primary LiveViews

#### TripsIndex (`/trips`)
**Purpose**: Trip listing and management hub  
**Features**: Trip cards, search/filter, create trip CTA  
**Assigns**: `trips`, `current_user`, `search_query`, `filters`

#### TripShow (`/trips/:id`)
**Purpose**: Trip detail view with tabbed navigation  
**Features**: Trip metadata, member list, gear/itinerary tabs  
**Assigns**: `trip`, `current_tab`, `members`, `can_edit`

#### GearIndex (`/trips/:trip_id/gear` or `/gear`)
**Purpose**: Gear inventory management  
**Features**: Gear list, sets, pack assignments  
**Assigns**: `gear_items`, `gear_sets`, `selected_set`, `pack_assignments`

#### GearSetEditor (`/trips/:trip_id/gear/sets/:set_id`)
**Purpose**: Gear set composition and editing  
**Features**: Set metadata, item selection, weight calculations  
**Assigns**: `gear_set`, `available_items`, `set_items`, `total_weight`

#### PackAssignment (`/trips/:trip_id/packs`)
**Purpose**: Daily pack planning and overrides  
**Features**: Day picker, set assignments, item overrides  
**Assigns**: `itinerary_days`, `assigned_sets`, `overrides`, `daily_weights`

#### ItineraryPlanner (`/trips/:trip_id/itinerary`)
**Purpose**: Daily itinerary and high-level meal planning  
**Features**: Day cards, activities, weather, mileage  
**Assigns**: `itinerary_days`, `weather_data`, `trail_data`

#### MealAllocation (`/trips/:trip_id/meals`)
**Purpose**: Detailed consumable allocation by day/meal  
**Features**: Consumable batches, meal grid, allocation controls  
**Assigns**: `consumable_batches`, `meal_allocations`, `itinerary_days`

### Supporting LiveComponents

#### GearItemForm
**Purpose**: Gear item create/edit modal  
**Props**: `gear_item`, `changeset`, `trip_id` (optional)  
**Events**: `save`, `cancel`, `photo_upload`

#### GearSetPicker
**Purpose**: Gear set selection dropdown/modal  
**Props**: `available_sets`, `selected_set_id`, `trip_id`  
**Events**: `set_selected`, `create_new_set`

#### AllTrailsLinkCard
**Purpose**: Trail metadata preview component  
**Props**: `trail_url`, `metadata`, `editable`  
**Events**: `fetch_metadata`, `remove_link`, `save_link`

#### OfflineBanner
**Purpose**: Connection status and sync indicator  
**Props**: `online_status`, `sync_status`, `pending_changes`  
**Events**: `retry_sync`, `dismiss`

#### RoleBadge
**Purpose**: Member role indicator  
**Props**: `role`, `user`, `editable`  
**Events**: `role_change_requested`

#### WeightTotals
**Purpose**: Pack weight calculation display  
**Props**: `base_weight`, `consumable_weight`, `worn_weight`  
**Updates**: Real-time calculation changes

## Routing Structure

```elixir
# Router configuration
scope "/", TrelixWeb do
  pipe_through [:browser, :require_authenticated_user]
  
  live "/trips", TripsIndex, :index
  live "/trips/new", TripsIndex, :new
  live "/trips/:id", TripShow, :show
  live "/trips/:id/edit", TripShow, :edit
  
  live "/trips/:trip_id/gear", GearIndex, :index
  live "/trips/:trip_id/gear/new", GearIndex, :new
  live "/trips/:trip_id/gear/:id/edit", GearIndex, :edit
  
  live "/trips/:trip_id/gear/sets", GearIndex, :sets
  live "/trips/:trip_id/gear/sets/:set_id", GearSetEditor, :edit
  
  live "/trips/:trip_id/packs", PackAssignment, :index
  live "/trips/:trip_id/itinerary", ItineraryPlanner, :index
  live "/trips/:trip_id/meals", MealAllocation, :index
  
  # Global gear management
  live "/gear", GearIndex, :global
end

# URL Parameters
:trip_id - UUID of trip
:id - UUID of specific resource (gear, set, etc.)
:day - Date or day number for itinerary
:meal_type - breakfast|lunch|dinner|snack
```

## PubSub & Presence Integration

### PubSub Topics
```elixir
# Real-time collaboration
"trip:#{trip_id}" - Trip-level updates
"trip:#{trip_id}:gear" - Gear changes
"trip:#{trip_id}:itinerary" - Itinerary updates
"trip:#{trip_id}:meals" - Meal allocation changes
"user:#{user_id}" - User-specific notifications

# System-wide
"sync:status" - Offline sync status updates
"alltrails:#{url_hash}" - Trail metadata updates
```

### Presence Tracking
```elixir
# Track active editors per trip
TrelixWeb.Presence.track(self(), "trip:#{trip_id}", user_id, %{
  current_screen: "gear_index",
  editing: nil,
  joined_at: System.system_time(:second)
})
```

### Event Broadcasting
```elixir
# Example gear item update
Phoenix.PubSub.broadcast(
  Trelix.PubSub,
  "trip:#{trip_id}:gear",
  {:gear_updated, gear_item, updated_by: user_id}
)
```

## State Management & Assigns

### Common Assigns Pattern
```elixir
# Base assigns for all trip-related views
%{
  current_user: user,
  trip: trip,
  can_edit: Trips.can_edit?(trip, user),
  online_status: :online | :offline,
  sync_status: :idle | :syncing | :error,
  pending_changes: integer(),
  members: [users],
  member_presence: %{user_id => presence_meta}
}
```

### View-Specific Assigns
```elixir
# GearIndex
%{
  gear_items: [items],
  gear_sets: [sets],
  selected_categories: [atoms],
  search_query: string(),
  view_mode: :list | :grid | :sets,
  total_weights: %{base: float, consumable: float, worn: float}
}

# MealAllocation  
%{
  consumable_batches: [batches],
  meal_allocations: %{day_date => %{meal_type => [allocations]}},
  selected_day: date(),
  selected_meal: atom(),
  allocation_form: changeset()
}
```

## Error Handling Patterns

### LiveView Error Recovery
```elixir
# Handle temporary PubSub failures
def handle_info({:error, :pubsub_timeout}, socket) do
  {:noreply, put_flash(socket, :info, "Reconnecting...")}
end

# Handle offline state transitions
def handle_info({:offline_mode, true}, socket) do
  socket = 
    socket
    |> assign(online_status: :offline)
    |> put_flash(:info, "You're offline. Changes will sync when reconnected.")
  
  {:noreply, socket}
end
```

### Form Validation & Recovery
```elixir
# Optimistic updates with rollback
def handle_event("save_gear", params, socket) do
  case Gear.update_item(socket.assigns.gear_item, params) do
    {:ok, gear_item} ->
      # Broadcast to collaborators
      broadcast_gear_update(gear_item, socket.assigns.current_user)
      {:noreply, assign(socket, gear_item: gear_item)}
    
    {:error, changeset} ->
      {:noreply, assign(socket, changeset: changeset)}
  end
end
```

## Offline Fallback Strategies

### Local Storage Integration
```elixir
# Queue changes for offline sync
def handle_event("save_offline", params, socket) do
  changeset = build_changeset(params)
  
  if changeset.valid? do
    # Store in local queue
    push_event(socket, "store_offline_change", %{
      type: "gear_update",
      data: params,
      timestamp: DateTime.utc_now()
    })
    
    # Optimistic UI update
    {:noreply, apply_optimistic_update(socket, params)}
  else
    {:noreply, assign(socket, changeset: changeset)}
  end
end
```

### Sync Conflict Resolution
```elixir
def handle_info({:sync_conflict, local_change, server_change}, socket) do
  socket = 
    socket
    |> assign(conflict_data: {local_change, server_change})
    |> assign(show_conflict_modal: true)
  
  {:noreply, socket}
end
```

## CSS Strategy (Tailwind)

### Component Classes
```elixir
# Utility modules for consistent styling
defmodule TrelixWeb.ComponentHelpers do
  def button_classes(variant \\ :primary) do
    base = "px-4 py-2 rounded-lg font-medium transition-colors"
    
    case variant do
      :primary -> "#{base} bg-green-600 text-white hover:bg-green-700"
      :secondary -> "#{base} bg-gray-200 text-gray-900 hover:bg-gray-300"
      :danger -> "#{base} bg-red-600 text-white hover:bg-red-700"
    end
  end
  
  def card_classes do
    "bg-white rounded-lg border border-gray-200 shadow-sm"
  end
end
```

### Responsive Breakpoints
```css
/* Mobile-first responsive design */
.gear-grid {
  @apply grid grid-cols-1 gap-4;
  @apply sm:grid-cols-2;
  @apply lg:grid-cols-3;
  @apply xl:grid-cols-4;
}

.trip-nav {
  @apply flex flex-col space-y-2;
  @apply sm:flex-row sm:space-y-0 sm:space-x-4;
}
```

## Testing Strategy

### LiveView Testing
```elixir
# Example LiveView test pattern
defmodule TrelixWeb.TripShowTest do
  use TrelixWeb.ConnCase, async: true
  import Phoenix.LiveViewTest
  
  test "displays trip details", %{conn: conn} do
    trip = trip_fixture()
    {:ok, view, html} = live(conn, ~p"/trips/#{trip.id}")
    
    assert html =~ trip.name
    assert has_element?(view, "[data-testid=trip-name]", trip.name)
  end
  
  test "handles real-time gear updates", %{conn: conn} do
    trip = trip_fixture()
    gear_item = gear_item_fixture(trip: trip)
    
    {:ok, view, _html} = live(conn, ~p"/trips/#{trip.id}")
    
    # Simulate another user updating gear
    Phoenix.PubSub.broadcast(
      Trelix.PubSub,
      "trip:#{trip.id}:gear",
      {:gear_updated, %{gear_item | name: "Updated Name"}}
    )
    
    assert render(view) =~ "Updated Name"
  end
end
```

### Component Testing
```elixir
# Component isolation testing
test "GearItemForm validates required fields" do
  assigns = %{gear_item: %GearItem{}, changeset: GearItem.changeset(%GearItem{})}
  
  html = render_component(GearItemForm, assigns)
  
  assert html =~ "required"
  assert has_element?(html, "input[name='gear_item[name]'][required]")
end
```

### E2E Testing (Wallaby/Playwright)
```elixir
# Critical user journey testing
feature "User creates trip with AllTrails link" do
  scenario "Happy path with valid trail URL" do
    user = create_user()
    
    session
    |> log_in(user)
    |> visit("/trips")
    |> click_link("Create trip")
    |> fill_in("Trip name", with: "Test Trip")
    |> fill_in("AllTrails link", with: "https://alltrails.com/valid-trail")
    |> click_button("Create trip")
    |> assert_text("Trail preview loaded")
    |> click_button("Save trip")
    |> assert_path("/trips/")
  end
end
```

## Performance Considerations

### LiveView Optimizations
- Use `temporary_assigns` for large lists that don't need diffing
- Implement pagination for gear lists (50 items per page)
- Debounce search inputs (300ms delay)
- Use `phx-update="stream"` for real-time lists
- Minimize assigns size in collaborative views

### Caching Strategy
- Cache AllTrails metadata (24 hour TTL)
- Cache gear weight calculations
- Use ETS for frequently accessed trip permissions
- Implement browser caching for static assets

---

**Implementation Priority**:
1. Core LiveViews (TripsIndex, TripShow, GearIndex)
2. Essential components (forms, navigation)
3. Offline support and sync
4. Real-time collaboration features
5. Advanced UX enhancements

**Development Notes**:
- Start with happy path implementations
- Add error handling and edge cases iteratively  
- Use feature flags for complex offline features
- Implement comprehensive logging for sync debugging