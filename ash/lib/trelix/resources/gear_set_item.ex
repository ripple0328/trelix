defmodule Trelix.Resources.GearSetItem do
  use Ash.Resource,
    data_layer: AshPostgres.DataLayer

  postgres do
    table "gear_set_items"
    repo Trelix.Repo
  end

  actions do
    defaults [:create, :read, :update, :destroy]
  end
  attributes do
    uuid_primary_key :id
    attribute :quantity_override, :integer
    attribute :worn_override, :boolean
    attribute :consumable_override, :boolean
  end

  relationships do
    belongs_to :gear_set, Trelix.Resources.GearSet, attribute_writable?: true, allow_nil?: false
    belongs_to :gear_item, Trelix.Resources.GearItem, attribute_writable?: true, allow_nil?: false
  end

  identities do
    identity :unique_join, [:gear_set_id, :gear_item_id]
  end

end
