class ParkingLot
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name
  field :address
  field :entry_point
  field :flat_rate
  field :overnight_rate
  field :small_parking_rate
  field :medium_parking_rate
  field :large_parking_rate
  field :flat_rate_duration
end
