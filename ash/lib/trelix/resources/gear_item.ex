defmodule Trelix.Resources.GearItem do
  use Ash.Resource,
    data_layer: AshPostgres.DataLayer

  postgres do
    table "gear_items"
    repo Trelix.Repo
  end

  actions do
    defaults [:create, :read, :update, :destroy]
  end
  attributes do
    uuid_primary_key :id
    attribute :name, :string, allow_nil?: false
    attribute :photo_url, :string
    attribute :weight, :decimal, allow_nil?: false, constraints: [min: 0]
    attribute :weight_unit, :atom, allow_nil?: false, constraints: [one_of: [:g, :kg, :oz, :lb]]
    attribute :category, :atom, allow_nil?: false, constraints: [one_of: [:shelter,:sleep,:pack,:clothing,:cook,:water,:nav,:first_aid,:electronics,:food,:misc]]
    attribute :description, :string
    attribute :url, :string
    attribute :quantity, :integer, default: 1, constraints: [min: 0]
    attribute :worn, :boolean, default: false
    attribute :starred, :boolean, default: false
    attribute :consumable, :boolean, default: false
    create_timestamp :created_at
    update_timestamp :updated_at
  end

  relationships do
    belongs_to :owner, Trelix.Resources.User, attribute_writable?: true, allow_nil?: false
    many_to_many :gear_sets, Trelix.Resources.GearSet,
      through: Trelix.Resources.GearSetItem,
      source_field_on_join_resource: :gear_item_id,
      destination_field_on_join_resource: :gear_set_id
  end

end
