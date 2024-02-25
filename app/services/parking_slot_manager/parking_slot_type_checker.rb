module ParkingSlotManager
  class ParkingSlotTypeChecker < ApplicationService

    def initialize vehicle_type
      @vehicle_type = vehicle_type
    end

    def call

      case @vehicle_type.to_sym
      when :small
        [:small, :medium, :large]
      when :medium
        [:medium, :large]
      when :large
        [:large]
      end

    end

  end
end
