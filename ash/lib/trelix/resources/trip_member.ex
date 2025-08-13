defmodule Trelix.Resources.TripMember do
  use Ash.Resource,
    data_layer: AshPostgres.DataLayer

  postgres do
    table "trip_members"
    repo Trelix.Repo
  end

  actions do
    defaults [:create, :read, :update, :destroy]
  end
  attributes do
    uuid_primary_key :id
    attribute :role, :atom, constraints: [one_of: [:leader, :member]], default: :member
    create_timestamp :created_at
  end

  relationships do
    belongs_to :trip, Trelix.Resources.Trip, attribute_writable?: true, allow_nil?: false
    belongs_to :user, Trelix.Resources.User, attribute_writable?: true, allow_nil?: false
    belongs_to :gear_set, Trelix.Resources.GearSet, attribute_writable?: true
  end

  identities do
    identity :unique_member, [:trip_id, :user_id]
  end

end
