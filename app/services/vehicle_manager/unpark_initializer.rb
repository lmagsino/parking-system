module VehicleManager
  class UnparkInitializer < ApplicationService

    def initialize plate_number, transaction_time
      @plate_number = plate_number
      @transaction_time = transaction_time
    end

    def call
      vehicle = Vehicle.plate_number_is(@plate_number).first

      ParkingSlotManager::ParkingSlotReleaser.call(
        vehicle,
        @transaction_time
      )
    end

  end
end
