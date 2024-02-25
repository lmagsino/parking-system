class VehiclesController < ApplicationController

  def park
    parking_transaction =
      VehicleManager::ParkInitializer.call(
        vehicle_params,
        parking_slot_params,
        params[:transaction_time]
      )

    if parking_transaction.present?
      status = :created
      result = {:location => parking_transaction.parking_slot.location}
    else
      status = :bad_request
      result = {:message => 'Sorry, No available parking slot for you'}
    end

    render :json => result, :status => status
  end

  def unpark
    parking_transaction =
      VehicleManager::UnparkInitializer.call(
        params[:plate_number], params[:transaction_time]
      )

    if parking_transaction.present?
      status = :ok
      result = {:amount => parking_transaction.amount}
    else
      status = :bad_request
      result =
        {:message => 'Error retrieving the total amount. Please try again.'}
    end

    render :json => result, :status => status
  end



  private

    def vehicle_params
      {
        :plate_number => params[:plate_number],
        :vehicle_type => params[:vehicle_type]
      }
    end

    def parking_slot_params
      {
        :parking_lot => ParkingLot.first,
        :entry_point => AlphanumericUtility.letter_to_number(params[:entry_point])
      }
    end

end
