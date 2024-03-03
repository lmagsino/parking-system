module ParkingSlotManager
  class ParkingSlotReleaser < ApplicationService

    attr_reader :vehicle, :transaction_time



    def initialize vehicle, transaction_time
      @vehicle = vehicle
      @transaction_time = transaction_time
    end

    def call
      parking_transaction = vehicle.latest_parking_transaction

      raise StandardError, 'Parking transaction not found' unless parking_transaction

      update_parking_transaction parking_transaction
    end



    private

    def update_parking_transaction parking_transaction
      parking_transaction.end_time = @transaction_time.to_datetime
      validate_end_time parking_transaction

      parking_transaction.complete
      parking_transaction
    end

    def validate_end_time parking_transaction
      if parking_transaction.start_time >= parking_transaction.end_time
        raise StandardError, 'End time for parking reservation precedes start time.'
      end
    end

  end
end
