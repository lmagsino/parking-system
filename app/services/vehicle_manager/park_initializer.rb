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
      if @vehicle.parking_transactions.ongoing.present?
        raise StandardError, 'You are already parked.'
      end
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
