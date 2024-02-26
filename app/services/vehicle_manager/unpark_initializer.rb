module VehicleManager
  class UnparkInitializer < ApplicationService

    attr_reader :plate_number, :transaction_time



    def initialize plate_number, transaction_time
      @plate_number = plate_number
      @transaction_time = transaction_time
    end

    def call
      vehicle = Vehicle.plate_number_is(@plate_number).first

      raise StandardError, 'Vehicle not found' unless vehicle

      ParkingSlotManager::ParkingSlotReleaser.call(
        vehicle,
        @transaction_time
      )

    rescue StandardError => e
      handle_error "Error in UnparkInitializer: #{e.message}"
    end
  end
end
