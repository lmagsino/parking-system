module VehicleManager
  class ParkInitializer < ApplicationService

    attr_reader :vehicle, :parking_slot, :transaction_time



    def initialize vehicle, parking_slot, transaction_time
      @vehicle = vehicle
      @parking_slot = parking_slot
      @transaction_time = transaction_time
    end

    def call
      begin
        ParkingSlotManager::ParkingSlotAssignor.call(
          get_vehicle,
          get_parking_slot,
          @transaction_time
        )
      rescue StandardError => e
        handle_error "Error in ParkInitializer: #{e.message}"
      end
    end



    private

    def get_vehicle
      VehicleInitializer.call @vehicle
    end

    def get_parking_slot
      parking_types =
        ParkingSlotManager::ParkingSlotTypeChecker.call(
          @vehicle[:vehicle_type]
        )

      ParkingSlotManager::ParkingSlotChecker.call(
        @parking_slot[:parking_lot],
        parking_types,
        @parking_slot[:entry_point]
      )
    end

  end
end
