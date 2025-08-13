defmodule Trelix.Resources.TripItem do
  use Ash.Resource,
    data_layer: AshPostgres.DataLayer

  postgres do
    table "trip_items"
    repo Trelix.Repo
  end

  actions do
    defaults [:create, :read, :update, :destroy]
  end
  attributes do
    uuid_primary_key :id
    attribute :quantity, :integer, default: 1, constraints: [min: 0]
    attribute :worn, :boolean, default: false
    attribute :consumable, :boolean, default: false
    attribute :total_weight_grams, :integer
  end

  relationships do
    belongs_to :trip, Trelix.Resources.Trip, attribute_writable?: true, allow_nil?: false
    belongs_to :gear_item, Trelix.Resources.GearItem, attribute_writable?: true, allow_nil?: false
    belongs_to :pack, Trelix.Resources.Pack, attribute_writable?: true, allow_nil?: true
  end

end
