defmodule Trelix.Resources.WeatherForecast do
  use Ash.Resource,
    data_layer: AshPostgres.DataLayer

  postgres do
    table "weather_forecasts"
    repo Trelix.Repo
  end

  actions do
    defaults [:create, :read, :update, :destroy]
  end
  attributes do
    uuid_primary_key :id
    attribute :date, :date, allow_nil?: false
    attribute :summary, :string
    attribute :temp_min_c, :decimal
    attribute :temp_max_c, :decimal
    attribute :precip_mm, :decimal
    attribute :wind_kph, :decimal
    attribute :raw_meta, :map
    create_timestamp :created_at
    update_timestamp :updated_at
  end

  relationships do
    belongs_to :trip, Trelix.Resources.Trip, attribute_writable?: true, allow_nil?: false
  end

end
