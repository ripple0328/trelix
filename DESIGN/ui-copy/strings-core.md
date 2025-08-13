# Trelix Core UI Strings

**Purpose**: Centralized copy for core user flows with consistent tone and i18n considerations  
**Tone**: Clear, concise, friendly, outdoor-oriented  
**Updated**: 2025-08-13

## Trip Creation & Management

### Labels & Inputs
| String | Copy | i18n Key |
|--------|------|----------|
| Trip Name | Trip name | `trips.form.name_label` |
| Trip Name Placeholder | "John Muir Trail 2025" | `trips.form.name_placeholder` |
| Trip Type | Trip type | `trips.form.type_label` |
| Destination | Destination | `trips.form.destination_label` |
| Destination Placeholder | "Yosemite National Park" | `trips.form.destination_placeholder` |
| Departure Location | Starting from | `trips.form.departure_label` |
| Departure Placeholder | "San Francisco, CA" | `trips.form.departure_placeholder` |
| Start Date | Start date | `trips.form.start_date_label` |
| End Date | End date | `trips.form.end_date_label` |
| AllTrails Link | AllTrails link (optional) | `trips.form.alltrails_label` |
| AllTrails Placeholder | "Paste AllTrails URL here" | `trips.form.alltrails_placeholder` |

### Actions
| String | Copy | i18n Key |
|--------|------|----------|
| Create Trip | Create trip | `trips.actions.create` |
| Save Changes | Save changes | `trips.actions.save` |
| Cancel | Cancel | `trips.actions.cancel` |
| Delete Trip | Delete trip | `trips.actions.delete` |

### Hints & Help
| String | Copy | i18n Key |
|--------|------|----------|
| AllTrails Help | "Add an AllTrails link to import trail stats automatically" | `trips.hints.alltrails_help` |
| Date Range Help | "Select your planned trip dates" | `trips.hints.date_range` |

### Errors
| String | Copy | i18n Key |
|--------|------|----------|
| Name Required | "Trip name is required" | `trips.errors.name_required` |
| Invalid Date Range | "End date must be after start date" | `trips.errors.invalid_date_range` |
| Invalid AllTrails URL | "Please enter a valid AllTrails link" | `trips.errors.invalid_alltrails_url` |
| Creation Failed | "Couldn't create trip. Please try again." | `trips.errors.creation_failed` |

## Gear Items & Management

### Labels & Inputs
| String | Copy | i18n Key |
|--------|------|----------|
| Item Name | Gear name | `gear.form.name_label` |
| Item Placeholder | "REI Co-op Flash 22 Pack" | `gear.form.name_placeholder` |
| Weight | Weight | `gear.form.weight_label` |
| Weight Placeholder | "2.1" | `gear.form.weight_placeholder` |
| Weight Unit | Unit | `gear.form.weight_unit_label` |
| Category | Category | `gear.form.category_label` |
| Description | Description | `gear.form.description_label` |
| Description Placeholder | "Lightweight daypack for summit pushes" | `gear.form.description_placeholder` |
| Product URL | Product link | `gear.form.url_label` |
| Quantity | Quantity | `gear.form.quantity_label` |
| Photo | Photo | `gear.form.photo_label` |

### Gear States
| String | Copy | i18n Key |
|--------|------|----------|
| Worn Weight | Worn (not counted in pack weight) | `gear.states.worn` |
| Starred Item | Essential item | `gear.states.starred` |
| Consumable | Consumable (food, fuel, etc.) | `gear.states.consumable` |

### Actions
| String | Copy | i18n Key |
|--------|------|----------|
| Add Gear | Add gear | `gear.actions.add` |
| Save Item | Save item | `gear.actions.save` |
| Delete Item | Delete item | `gear.actions.delete` |
| Add to Set | Add to gear set | `gear.actions.add_to_set` |
| Take Photo | Take photo | `gear.actions.take_photo` |
| Choose Photo | Choose from library | `gear.actions.choose_photo` |

### Errors
| String | Copy | i18n Key |
|--------|------|----------|
| Name Required | "Gear name is required" | `gear.errors.name_required` |
| Invalid Weight | "Weight must be a positive number" | `gear.errors.invalid_weight` |
| Photo Upload Failed | "Photo upload failed. Try again." | `gear.errors.photo_upload_failed` |

## Consumable Allocation

### Day & Meal Selection
| String | Copy | i18n Key |
|--------|------|----------|
| Select Day | Day | `consumables.labels.select_day` |
| Select Meal | Meal | `consumables.labels.select_meal` |
| Breakfast | Breakfast | `consumables.meals.breakfast` |
| Lunch | Lunch | `consumables.meals.lunch` |
| Dinner | Dinner | `consumables.meals.dinner` |
| Snack | Snacks | `consumables.meals.snack` |

### Allocation Controls
| String | Copy | i18n Key |
|--------|------|----------|
| Amount | Amount | `consumables.labels.amount` |
| Amount Placeholder | "150" | `consumables.placeholders.amount` |
| Unit Grams | grams | `consumables.units.grams` |
| Unit ML | ml | `consumables.units.ml` |
| Remaining | remaining | `consumables.labels.remaining` |
| Allocated | allocated | `consumables.labels.allocated` |

### Batch Management
| String | Copy | i18n Key |
|--------|------|----------|
| Create Batch | Create batch | `consumables.actions.create_batch` |
| Batch Name | Batch name | `consumables.labels.batch_name` |
| Total Quantity | Total quantity | `consumables.labels.total_quantity` |
| No Batches | "No consumable batches yet. Create one to start allocating meals." | `consumables.empty.no_batches` |

### Errors
| String | Copy | i18n Key |
|--------|------|----------|
| Insufficient Quantity | "Not enough remaining in batch" | `consumables.errors.insufficient_quantity` |
| Invalid Amount | "Amount must be greater than 0" | `consumables.errors.invalid_amount` |
| Allocation Failed | "Couldn't save allocation. Try again." | `consumables.errors.allocation_failed` |

## Sharing & Permissions

### Role Labels
| String | Copy | i18n Key |
|--------|------|----------|
| Owner | Owner | `sharing.roles.owner` |
| Editor | Editor | `sharing.roles.editor` |
| Viewer | Viewer | `sharing.roles.viewer` |

### Permission Descriptions
| String | Copy | i18n Key |
|--------|------|----------|
| Owner Description | "Full access: edit trip, manage members, delete" | `sharing.descriptions.owner` |
| Editor Description | "Can edit trip details and gear lists" | `sharing.descriptions.editor` |
| Viewer Description | "Can view trip details and gear lists" | `sharing.descriptions.viewer` |

### Sharing Actions
| String | Copy | i18n Key |
|--------|------|----------|
| Invite Members | Invite members | `sharing.actions.invite` |
| Change Role | Change role | `sharing.actions.change_role` |
| Remove Member | Remove member | `sharing.actions.remove` |
| Copy Link | Copy trip link | `sharing.actions.copy_link` |

### Sharing Errors
| String | Copy | i18n Key |
|--------|------|----------|
| Invalid Email | "Please enter a valid email address" | `sharing.errors.invalid_email` |
| Already Member | "This person is already a trip member" | `sharing.errors.already_member` |
| Invite Failed | "Couldn't send invitation. Try again." | `sharing.errors.invite_failed` |

## Empty States

### Trip Lists
| String | Copy | i18n Key |
|--------|------|----------|
| No Trips | "Ready for your next adventure?" | `empty_states.trips.title` |
| No Trips Subtitle | "Create your first trip to start planning" | `empty_states.trips.subtitle` |
| No Trips Action | "Create trip" | `empty_states.trips.action` |

### Gear Lists
| String | Copy | i18n Key |
|--------|------|----------|
| No Gear | "Build your gear collection" | `empty_states.gear.title` |
| No Gear Subtitle | "Add gear items to track weight and organize your kit" | `empty_states.gear.subtitle` |
| No Gear Action | "Add gear" | `empty_states.gear.action` |

### Itinerary
| String | Copy | i18n Key |
|--------|------|----------|
| No Itinerary | "Plan your days" | `empty_states.itinerary.title` |
| No Itinerary Subtitle | "Add daily plans and allocate meals" | `empty_states.itinerary.subtitle` |

## Offline & Sync States

### Offline Banners
| String | Copy | i18n Key |
|--------|------|----------|
| Offline Mode | "You're offline. Changes will sync when reconnected." | `offline.banner.offline_mode` |
| Syncing | "Syncing changes..." | `offline.banner.syncing` |
| Sync Complete | "All changes synced" | `offline.banner.sync_complete` |
| Sync Failed | "Some changes couldn't sync. Tap to retry." | `offline.banner.sync_failed` |

### Conflict Resolution
| String | Copy | i18n Key |
|--------|------|----------|
| Conflicts Found | "Conflicting changes found" | `sync.conflicts.title` |
| Conflicts Subtitle | "Choose which version to keep" | `sync.conflicts.subtitle` |
| Keep Mine | "Keep my version" | `sync.conflicts.keep_mine` |
| Keep Theirs | "Keep their version" | `sync.conflicts.keep_theirs` |
| Merge Changes | "Merge changes" | `sync.conflicts.merge` |

## Loading States

### General Loading
| String | Copy | i18n Key |
|--------|------|----------|
| Loading | "Loading..." | `loading.general` |
| Saving | "Saving..." | `loading.saving` |
| Creating | "Creating..." | `loading.creating` |
| Updating | "Updating..." | `loading.updating` |

### Specific Loading
| String | Copy | i18n Key |
|--------|------|----------|
| Loading Trip | "Loading trip details..." | `loading.trip` |
| Loading Gear | "Loading gear..." | `loading.gear` |
| Fetching Trail Info | "Getting trail info..." | `loading.alltrails` |

## Weight & Measurements

### Weight Display
| String | Copy | i18n Key |
|--------|------|----------|
| Total Weight | "Total pack weight" | `weight.total_pack` |
| Base Weight | "Base weight" | `weight.base` |
| Consumable Weight | "Food & fuel" | `weight.consumables` |
| Worn Weight | "Worn weight" | `weight.worn` |

### Units
| String | Copy | i18n Key |
|--------|------|----------|
| Pounds | lbs | `units.pounds` |
| Ounces | oz | `units.ounces` |
| Kilograms | kg | `units.kilograms` |
| Grams | g | `units.grams` |

---

**Style Notes**:
- Use sentence case for labels and buttons
- Keep error messages actionable and specific
- Outdoor terminology when appropriate ("pack weight" vs "bag weight")
- Friendly but not overly casual tone
- Front-load important information in longer copy