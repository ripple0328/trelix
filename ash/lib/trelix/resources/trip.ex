defmodule Trelix.Resources.Trip do
  use Ash.Resource,
    data_layer: AshPostgres.DataLayer

  postgres do
    table "trips"
    repo Trelix.Repo
  end

  actions do
    defaults [:create, :read, :update, :destroy]
  end
  attributes do
    uuid_primary_key :id
    attribute :name, :string, allow_nil?: false
    attribute :type, :atom, constraints: [one_of: [:backpacking, :camping]], allow_nil?: false
    attribute :destination, :string
    attribute :depart_location, :string
    attribute :start_date, :date, allow_nil?: false
    attribute :end_date, :date
    attribute :notes, :string
    attribute :visibility, :atom, constraints: [one_of: [:public, :friends, :private]], default: :private
    create_timestamp :created_at
    update_timestamp :updated_at
  end

  relationships do
    belongs_to :owner, Trelix.Resources.User, attribute_writable?: true, allow_nil?: false
    has_many :memberships, Trelix.Resources.TripMember, destination_field: :trip_id
    has_many :packs, Trelix.Resources.Pack, destination_field: :trip_id
    has_many :trip_gear_sets, Trelix.Resources.TripGearSet, destination_field: :trip_id
    has_many :trail_links, Trelix.Resources.TrailLink, destination_field: :trip_id
    has_many :weather_forecasts, Trelix.Resources.WeatherForecast, destination_field: :trip_id
    has_many :itinerary_days, Trelix.Resources.ItineraryDay, destination_field: :trip_id
  end

end
