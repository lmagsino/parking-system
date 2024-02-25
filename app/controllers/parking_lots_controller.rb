class ParkingLotsController < ApplicationController

  before_action :set_parking_lot, only: %i[ show update destroy ]



  def index
    @parking_lots = ParkingLot.all

    render_json @parking_lots, :ok
  end

  def show
    render_json @parking_lot, :ok
  end

  def create
    @parking_lot = ParkingLot.new parking_lot_params

    if @parking_lot.save
      render_json @parking_lot, :created
    else
      render_errors @parking_lot.errors, :unprocessable_entity
    end
  end

  def update
    if @parking_lot.update parking_lot_params
      render_json @parking_lot, :ok
    else
      render_errors @parking_lot.errors, :unprocessable_entity
    end
  end

  def destroy
    @parking_lot.destroy!

    head :ok
  end

  def entry_points
    @parking_lot = ParkingLot.first
    @entry_points = EntryPointsGenerator.call @parking_lot.entry_point

    render_json @entry_points, :ok
  end



  private

    def set_parking_lot
      @parking_lot = ParkingLot.find params[:id]
    end

    def parking_lot_params
      params.require(:parking_lot).permit(
        :name, :address, :entry_point, :flat_rate, :overnight_rate,
        :small_parking_rate, :medium_parking_rate, :large_parking_rate,
        :flat_rate_duration
      )
    end

end
