module VehicleManager
  class VehicleInitializer < ApplicationService

    def initialize vehicle_params
      @vehicle_params = vehicle_params
    end

    def call
      existing_vehicle = get_existing_vehicle

      if existing_vehicle
        existing_vehicle.vehicle_type = @vehicle_params[:vehicle_type]
        existing_vehicle.save
        return existing_vehicle
      end

      create_new_vehicle
    end



    private

    def get_existing_vehicle
      Vehicle.plate_number_is(@vehicle_params[:plate_number]).first
    end

    def create_new_vehicle
      VehicleCreator.call @vehicle_params
    end

  end
end
