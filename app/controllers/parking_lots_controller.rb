class ParkingLotsController < ApplicationController

  before_action :set_parking_lot, only: %i[ show update destroy ]



  def index
    @parking_lots = ParkingLot.all

    render json: @parking_lots
  end

  def show
    render json: @parking_lot
  end

  def create
    @parking_lot = ParkingLot.new parking_lot_params

    if @parking_lot.save
      render :json => @parking_lot, :status => :created
    else
      render :json => @parking_lot.errors, :status => :unprocessable_entity
    end
  end

  def update
    if @parking_lot.update parking_lot_params
      render :json => @parking_lot, :status => :ok
    else
      render :json => @parking_lot.errors, :status => :unprocessable_entity
    end
  end

  def destroy
    @parking_lot.destroy!

    render :status => :ok
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
