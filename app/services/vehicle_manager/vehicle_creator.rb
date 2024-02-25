module VehicleManager
  class VehicleCreator < ApplicationService

    def initialize vehicle
      @vehicle = vehicle
    end

    def call
      Vehicle.create @vehicle
    end

  end
end
