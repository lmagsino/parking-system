class ParkingSlotsController < ApplicationController
  before_action :set_parking_slot, only: %i[ show update destroy ]



  def index
    @parking_slots = ParkingSlot.all

    render json: @parking_lots
  end

  def show
    render json: @parking_lot
  end

  def create
    @parking_slot = ParkingSlot.new parking_slot_params

    if @parking_slot.save
      render :json => @parking_slot, :status => :created
    else
      render :json => @parking_slot.errors, :status => :unprocessable_entity
    end
  end

  def update
    if @parking_slot.update parking_slot_params
      render :json => @parking_slot, :status => :ok
    else
      render :json => @parking_slot.errors, :status => :unprocessable_entity
    end
  end

  def destroy
    @parking_slot.destroy!

    render :status => :ok
  end



  private

    def set_parking_slot
      @parking_slot = ParkingSlot.find params[:id]
    end

    def parking_slot_params
      params.require(:parking_slot).permit :parking_lot_id, :parking_type
    end
end
