module ParkingSlotManager
  class ParkingSlotCreator < ApplicationService

    def initialize parking_slot_params
      @parking_slot_params = parking_slot_params

    end

    # Creates a new parking slot.
    def call
      ParkingSlot.create! @parking_slot_params
    rescue StandardError => e
      handle_error "Failed to create parking slot: #{e.message}"
    end

  end
end
