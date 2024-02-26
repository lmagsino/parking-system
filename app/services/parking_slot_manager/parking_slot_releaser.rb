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
    rescue StandardError => e
      handle_error "Error in ParkingSlotReleaser: #{e.message}"
    end



    private

    def update_parking_transaction parking_transaction
      parking_transaction.end_time = @transaction_time.to_datetime
      parking_transaction.complete
      parking_transaction
    end

  end
end
