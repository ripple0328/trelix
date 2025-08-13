defmodule Trelix.Resources.ItineraryDay do
  use Ash.Resource,
    data_layer: AshPostgres.DataLayer

  postgres do
    table "itinerary_days"
    repo Trelix.Repo
  end

  actions do
    defaults [:create, :read, :update, :destroy]
  end
  attributes do
    uuid_primary_key :id
    attribute :day_index, :integer, allow_nil?: false
    attribute :date, :date
    attribute :notes, :string
    create_timestamp :created_at
    update_timestamp :updated_at
  end

  relationships do
    belongs_to :trip, Trelix.Resources.Trip, attribute_writable?: true, allow_nil?: false
    has_many :allocations, Trelix.Resources.MealAllocation, destination_field: :itinerary_day_id
  end

end
