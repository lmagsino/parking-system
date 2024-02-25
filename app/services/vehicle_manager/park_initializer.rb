module VehicleManager
  class ParkInitializer < ApplicationService

    def initialize vehicle, parking_slot, transaction_time
      @vehicle = vehicle
      @parking_slot = parking_slot
      @transaction_time = transaction_time
    end

    def call
      ParkingSlotManager::ParkingSlotAssignor.call(
        get_vehicle,
        get_parking_slot,
        @transaction_time
      )
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
