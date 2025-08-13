defmodule Trelix.Resources.Reaction do
  use Ash.Resource,
    data_layer: AshPostgres.DataLayer

  postgres do
    table "reactions"
    repo Trelix.Repo
  end

  actions do
    defaults [:create, :read, :update, :destroy]
  end
  attributes do
    uuid_primary_key :id
    attribute :emoji, :string, allow_nil?: false
    create_timestamp :created_at
  end

  relationships do
    belongs_to :trip, Trelix.Resources.Trip, attribute_writable?: true, allow_nil?: false
    belongs_to :user, Trelix.Resources.User, attribute_writable?: true, allow_nil?: false
  end

end
