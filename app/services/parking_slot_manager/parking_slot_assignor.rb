module ParkingSlotManager
  class ParkingSlotAssignor < ApplicationService

    def initialize vehicle, parking_slot, transaction_time
      @vehicle = vehicle
      @parking_slot = parking_slot
      @transaction_time = transaction_time
    end

    def call
      return false unless @parking_slot

      parking_transaction = create_parking_transaction

      parking_transaction.start
      parking_transaction
    end



    private

      def create_parking_transaction
        parking_transaction =
          ParkingTransactionCreator.call(
            {
              :vehicle => @vehicle,
              :parking_slot => @parking_slot,
              :start_time => @transaction_time.to_datetime
            }
          )

        parking_transaction.returning = is_vehicle_returning
        parking_transaction
      end

      def is_vehicle_returning
        VehicleManager::VehicleReturningChecker.call @vehicle, @transaction_time
      end

  end
end

