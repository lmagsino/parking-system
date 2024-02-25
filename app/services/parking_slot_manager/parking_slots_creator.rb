module ParkingSlotManager
  class ParkingSlotsCreator < ApplicationService

    def initialize parking_slot, locations
      @parking_slot = parking_slot
      @locations = locations
    end

    def call
      @locations.each do |location|
        @parking_slot[:location] = location
        ParkingSlotCreator.call @parking_slot
      end
    end

  end
end
