class VehiclesController < ApplicationController

  rescue_from StandardError, :with => :handle_error

  def park
    parking_transaction =
      VehicleManager::ParkInitializer.call(
        vehicle_params,
        parking_slot_params,
        params[:transaction_time]
      )

    if parking_transaction
      render_json({:location => parking_transaction.parking_slot.location}, :ok)
    else
      render_json({:message => 'Sorry, No available parking slot for now.'}, :bad_request)
    end
  end

  def unpark
    parking_transaction =
      VehicleManager::UnparkInitializer.call(
        params[:plate_number], params[:transaction_time]
      )

    if parking_transaction
      render_json(
        {
          :paid_amount => parking_transaction.paid_amount,
          :pending_amount => parking_transaction.amount,
          :total_amount => parking_transaction.total_amount
        },
        :ok
      )
    else
      render_json({:message => 'Error retrieving the total amount. Please try again.'}, :bad_request)
    end
  end



  private

  def vehicle_params
    params.permit :plate_number, :vehicle_type
  end

  def parking_slot_params
    {
      :parking_lot => ParkingLot.first,
      :entry_point => AlphanumericUtility.letter_to_number(params[:entry_point])
    }
  end

end
