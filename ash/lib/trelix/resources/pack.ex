defmodule Trelix.Resources.Pack do
  use Ash.Resource,
    data_layer: AshPostgres.DataLayer

  postgres do
    table "packs"
    repo Trelix.Repo
  end

  actions do
    defaults [:create, :read, :update, :destroy]
  end
  attributes do
    uuid_primary_key :id
    attribute :name, :string, allow_nil?: false
    attribute :capacity_liters, :integer
    attribute :notes, :string
    create_timestamp :created_at
    update_timestamp :updated_at
  end

  relationships do
    belongs_to :trip, Trelix.Resources.Trip, attribute_writable?: true, allow_nil?: false
  end

end
