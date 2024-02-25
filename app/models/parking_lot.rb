class ParkingLot

  include Mongoid::Document
  include Mongoid::Timestamps

  has_many :parking_slots

  field :name, :type => String
  field :address, :type => String
  field :entry_point, :type => Integer
  field :flat_rate, :type => BigDecimal
  field :overnight_rate, :type => BigDecimal
  field :small_parking_rate, :type => BigDecimal
  field :medium_parking_rate, :type => BigDecimal
  field :large_parking_rate, :type => BigDecimal
  field :flat_rate_duration, :type => Integer

  MIN_ENTRY_POINT = 3

  validates :name, :address, presence: true
  validates :entry_point, presence: true, numericality: { greater_than_or_equal_to: MIN_ENTRY_POINT }
  validates :flat_rate, :overnight_rate, :small_parking_rate, :medium_parking_rate,
            :large_parking_rate, :flat_rate_duration, presence: true,
            numericality: { greater_than_or_equal_to: 0 }

end
