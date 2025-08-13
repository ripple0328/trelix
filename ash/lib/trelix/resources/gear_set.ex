defmodule Trelix.Resources.GearSet do
  use Ash.Resource,
    data_layer: AshPostgres.DataLayer

  postgres do
    table "gear_sets"
    repo Trelix.Repo
  end

  actions do
    defaults [:create, :read, :update, :destroy]
  end
  attributes do
    uuid_primary_key :id
    attribute :name, :string, allow_nil?: false
    attribute :scenario, :atom, constraints: [one_of: [:backpacking, :camping]], allow_nil?: false
    attribute :description, :string
    attribute :is_template, :boolean, default: false
    create_timestamp :created_at
  end

  relationships do
    belongs_to :owner, Trelix.Resources.User, attribute_writable?: true, allow_nil?: false
    has_many :gear_set_items, Trelix.Resources.GearSetItem, destination_field: :gear_set_id
  end

end
