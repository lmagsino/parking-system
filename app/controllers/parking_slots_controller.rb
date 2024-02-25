class ParkingSlotsController < ApplicationController
  before_action :set_parking_slot, only: %i[ show ]



  def index
    @parking_slots = ParkingSlot.all

    render json: @parking_slots
  end

  def show
    render json: @parking_slot
  end

  def create
    @parking_slots =
      ParkingSlotManager::ParkingSlotsCreator.call(
        parking_slot_params,
        params[:locations]
      )

    if @parking_slots.present?
      render :json => @parking_slots, :status => :created
    else
      render :json => @parking_slots.errors, :status => :unprocessable_entity
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
