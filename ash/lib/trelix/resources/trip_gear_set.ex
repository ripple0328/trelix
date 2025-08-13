defmodule Trelix.Resources.TripGearSet do
  use Ash.Resource,
    data_layer: AshPostgres.DataLayer

  postgres do
    table "trip_gear_sets"
    repo Trelix.Repo
  end

  actions do
    defaults [:create, :read, :update, :destroy]
  end
  attributes do
    uuid_primary_key :id
    attribute :pack_role, :string
  end

  relationships do
    belongs_to :trip, Trelix.Resources.Trip, attribute_writable?: true, allow_nil?: false
    belongs_to :gear_set, Trelix.Resources.GearSet, attribute_writable?: true, allow_nil?: false
  end

  identities do
    identity :unique_attach, [:trip_id, :gear_set_id]
  end

end
