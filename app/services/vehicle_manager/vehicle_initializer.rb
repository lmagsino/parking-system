module VehicleManager
  class VehicleInitializer < ApplicationService

    def initialize vehicle
      @vehicle = vehicle
    end

    def call
      vehicle = get_existing

      if vehicle.present?
        vehicle.type = vehicle[:type]
        vehicle.save
        return vehicle
      end

      vehicle = VehicleCreator.call @vehicle
      vehicle
    end



    private

    def get_existing
      Vehicle.plate_number_is(@vehicle[:plate_number]).first
    end

  end
end
