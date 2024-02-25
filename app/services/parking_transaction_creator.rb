class ParkingTransactionCreator < ApplicationService
  attr_reader :parking_transaction_params

  def initialize parking_transaction_params
    @parking_transaction_params = parking_transaction_params
  end

  def call
    begin
      parking_transaction = ParkingTransaction.create! parking_transaction_params
      parking_transaction
    rescue ActiveRecord::RecordInvalid => e
      handler_error "Error creating parking transaction: #{e.message}"
    end
  end

end
