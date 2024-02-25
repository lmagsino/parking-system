module ParkingSlotManager
  class ParkingSlotTypeChecker < ApplicationService

    attr_reader :vehicle_type

    VALID_VEHICLE_TYPES = ['small', 'medium', 'large'].freeze



    def initialize vehicle_type
      @vehicle_type = vehicle_type
    end

    def call

      validate_vehicle_type
      case vehicle_type
      when 'small'
        valid_types('small', 'medium', 'large')
      when 'medium'
        valid_types('medium', 'large')
      when 'large'
        valid_types('large')
      end

    end



    private

    def valid_types *types
      types & VALID_VEHICLE_TYPES
    end

    def validate_vehicle_type
      return if VALID_VEHICLE_TYPES.include? vehicle_type

      raise ArgumentError, "Invalid vehicle type: #{vehicle_type}"
    end

  end
end
