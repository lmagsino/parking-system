module VehicleManager
  class UnparkInitializer < ApplicationService

    attr_reader :plate_number, :transaction_time



    def initialize plate_number, transaction_time
      @plate_number = plate_number
      @transaction_time = transaction_time
    end

    def call
      validate_transaction_time
      vehicle = Vehicle.plate_number_is(@plate_number).first

      raise StandardError, 'Vehicle not found.' unless vehicle

      validate_transactions vehicle.parking_transactions.ongoing

      ParkingSlotManager::ParkingSlotReleaser.call(
        vehicle,
        @transaction_time
      )
    end



    private

    def validate_transaction_time
      return if DatetimeUtility.valid_datetime? @transaction_time
      raise StandardError, 'Invalid transaction time.'
    end

    def validate_transactions ongoing_transactions
      raise StandardError, 'No park vehicle.' unless ongoing_transactions.present?
    end

  end
end
