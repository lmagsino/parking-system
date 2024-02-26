module ParkingSlotManager
  class ParkingSlotsCreator < ApplicationService

    def initialize parking_slot_params, locations
      @parking_slot_params = parking_slot_params
      @locations = locations
    end

    # Creates parking slots for each location provided.
    def call
      @parking_lot = ParkingLot.find @parking_slot_params[:parking_lot_id]
      created_parking_slots = @locations.map do |location|
        create_parking_slot location
      end

      # Return an array of created parking slots without nil values.
      created_parking_slots.compact
    end



    private

    # Creates a parking slot for the given location.
    def create_parking_slot location
      modified_params = prepare_parking_slot_params location
      ParkingSlotCreator.call modified_params
    rescue StandardError => e
      error_message = "Failed to create parking slot for location '#{location}': #{e.message}"
      handle_error error_message
    end

    def prepare_parking_slot_params location
      {
        parking_lot: @parking_lot,
        parking_type: @parking_slot_params[:parking_type],
        location: location
      }
    end

  end
end
