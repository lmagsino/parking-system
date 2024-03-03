module VehicleManager
  class VehicleCreator < ApplicationService

    def initialize vehicle_params
      @vehicle_params = vehicle_params
    end

    def call
      Vehicle.create @vehicle_params
    end

  end
end
