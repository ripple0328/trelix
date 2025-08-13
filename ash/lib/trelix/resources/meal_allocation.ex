defmodule Trelix.Resources.MealAllocation do
  use Ash.Resource,
    data_layer: AshPostgres.DataLayer

  postgres do
    table "meal_allocations"
    repo Trelix.Repo
  end

  actions do
    defaults [:create, :read, :update, :destroy]
  end
  attributes do
    uuid_primary_key :id
    attribute :meal, :atom, constraints: [one_of: [:breakfast, :lunch, :dinner, :snack]], allow_nil?: false
    attribute :grams, :integer, allow_nil?: false
    create_timestamp :created_at
    update_timestamp :updated_at
  end

  relationships do
    belongs_to :itinerary_day, Trelix.Resources.ItineraryDay, attribute_writable?: true, allow_nil?: false
    belongs_to :consumable_batch, Trelix.Resources.ConsumableBatch, attribute_writable?: true, allow_nil?: false
    belongs_to :user, Trelix.Resources.User, attribute_writable?: true
  end

end
