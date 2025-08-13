defmodule Trelix.Resources.TripCollaborator do
  use Ash.Resource,
    data_layer: AshPostgres.DataLayer

  postgres do
    table "trip_collaborators"
    repo Trelix.Repo
  end

  actions do
    defaults [:create, :read, :update, :destroy]
  end
  attributes do
    uuid_primary_key :id
    attribute :role, :atom, constraints: [one_of: [:owner, :editor, :viewer]], default: :viewer
    create_timestamp :created_at
  end

  relationships do
    belongs_to :trip, Trelix.Resources.Trip, attribute_writable?: true, allow_nil?: false
    belongs_to :user, Trelix.Resources.User, attribute_writable?: true, allow_nil?: false
  end

  identities do
    identity :unique_collab, [:trip_id, :user_id]
  end

end
