module ParkingSlotManager
  class ParkingSlotCreator < ApplicationService

    def initialize parking_slot
      @parking_slot = parking_slot
    end

    def call
      ParkingSlot.create @parking_slot
    end

  end
end

