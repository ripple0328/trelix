defmodule Trelix.Domain do
  use Ash.Domain

  resources do
    resource Trelix.Resources.User
    resource Trelix.Resources.Follow
    resource Trelix.Resources.Trip
    resource Trelix.Resources.TripMember
    resource Trelix.Resources.TripCollaborator
    resource Trelix.Resources.Pack
    resource Trelix.Resources.GearItem
    resource Trelix.Resources.GearSet
    resource Trelix.Resources.GearSetItem
    resource Trelix.Resources.TripGearSet
    resource Trelix.Resources.TripItem
    resource Trelix.Resources.Reaction
    resource Trelix.Resources.Comment
    resource Trelix.Resources.TrailLink
    resource Trelix.Resources.WeatherForecast
    resource Trelix.Resources.ItineraryDay
    resource Trelix.Resources.MealAllocation
    resource Trelix.Resources.ConsumableBatch
  end
end
