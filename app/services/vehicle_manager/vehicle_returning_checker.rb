module VehicleManager
  class VehicleReturningChecker < ApplicationService

    attr_reader :vehicle, :transaction_time

    SECONDS_IN_HOUR = 3600



    def initialize vehicle, transaction_time

      @vehicle = vehicle
      @transaction_time = transaction_time

    end

    def call
      end_time = @vehicle.latest_completed_parking_transaction.try :end_time
      return false if end_time.nil?

      transaction_time = Time.parse @transaction_time.to_s
      end_time = Time.parse end_time.to_s

      total_time_difference = transaction_time - end_time
      total_time_difference <= SECONDS_IN_HOUR
    end

  end
end
