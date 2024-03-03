module VehicleManager
  class ParkInitializer < ApplicationService

    attr_reader :vehicle, :parking_slot, :transaction_time



    def initialize vehicle_params, parking_slot_params, transaction_time
      @vehicle = get_vehicle_instance vehicle_params
      @parking_slot_params = parking_slot_params
      @transaction_time = transaction_time
    end

    def call
      validate_transaction
      assign_parking_slot
    end



    private

    def validate_transaction
      validate_transaction_time
      raise StandardError, 'You are already parked.' if already_parked?
      validate_start_time
    end

    def validate_transaction_time
      return if DatetimeUtility.valid_datetime? @transaction_time
      raise StandardError, 'Invalid transaction time'
    end

    def already_parked?
      @vehicle.parking_transactions.ongoing.present?
    end

    def validate_start_time
      completed_transactions = @vehicle.parking_transactions.completed.ordered_by_end_time
      return unless completed_transactions.present?

      last_completed_transaction = completed_transactions.last
      return unless transaction_time < last_completed_transaction.end_time
      raise StandardError, 'Start time for parking reservation precedes previous parking time.'
    end

    def assign_parking_slot
      parking_slot = find_parking_slot get_parking_types

      ParkingSlotManager::ParkingSlotAssignor.call(
        @vehicle,
        parking_slot,
        @transaction_time
      )
    end

    def get_vehicle_instance vehicle
      VehicleInitializer.call vehicle
    end

    def get_parking_types
      ParkingSlotManager::ParkingSlotTypeChecker.call @vehicle.vehicle_type
    end

    def find_parking_slot parking_types
      ParkingSlotManager::ParkingSlotChecker.call(
        @parking_slot_params[:parking_lot],
        parking_types,
        @parking_slot_params[:entry_point]
      )
    end

  end
end
