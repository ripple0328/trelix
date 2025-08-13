defmodule Trelix.Resources.ConsumableBatch do
  use Ash.Resource,
    data_layer: AshPostgres.DataLayer

  postgres do
    table "consumable_batches"
    repo Trelix.Repo
  end

  actions do
    defaults [:create, :read, :update, :destroy]
  end
  attributes do
    uuid_primary_key :id
    attribute :label, :string
    attribute :grams_total, :integer, allow_nil?: false
    attribute :grams_remaining, :integer
    create_timestamp :created_at
    update_timestamp :updated_at
  end

  relationships do
    belongs_to :gear_item, Trelix.Resources.GearItem, attribute_writable?: true, allow_nil?: false
    belongs_to :trip, Trelix.Resources.Trip, attribute_writable?: true, allow_nil?: false
  end

end
