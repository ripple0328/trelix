defmodule Trelix.Resources.TrailLink do
  use Ash.Resource,
    data_layer: AshPostgres.DataLayer

  postgres do
    table "trail_links"
    repo Trelix.Repo
  end

  actions do
    defaults [:create, :read, :update, :destroy]
  end
  attributes do
    uuid_primary_key :id
    attribute :provider, :atom, constraints: [one_of: [:alltrails]], default: :alltrails
    attribute :url, :string, allow_nil?: false
    attribute :trail_name, :string
    attribute :distance_km, :decimal
    attribute :elevation_gain_m, :integer
    attribute :estimated_duration_h, :decimal
    attribute :difficulty, :string
    attribute :raw_meta, :map
    create_timestamp :created_at
    update_timestamp :updated_at
  end

  relationships do
    belongs_to :trip, Trelix.Resources.Trip, attribute_writable?: true, allow_nil?: false
  end

end
