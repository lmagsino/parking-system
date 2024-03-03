class ParkingSlotsController < ApplicationController

  rescue_from StandardError, :with => :handle_error

  before_action :set_parking_slot, only: %i[ show destroy ]



  def index
    @parking_slots = ParkingSlot.all

    render_json @parking_slots, :ok
  end

  def show
    render_json @parking_slot, :ok
  end

  def create
    @parking_slots =
      ParkingSlotManager::ParkingSlotsCreator.call(
        parking_slot_params,
        params[:locations]
      )

    if @parking_slots.present?
      render_json @parking_slots, :created
    else
      render_json 'Failed to create parking slot', :bad_request
    end
  end

  def destroy
    @parking_slot.destroy!

    head :ok
  end



  private

  def set_parking_slot
    @parking_slot = ParkingSlot.find params[:id]
  end

  def parking_slot_params
    params.require(:parking_slot).permit :parking_lot_id, :parking_type
  end

end
