class ParkingTransactionCreator < ApplicationService
  attr_reader :parking_transaction_params

  def initialize parking_transaction_params
    @parking_transaction_params = parking_transaction_params
  end

  def call
    ParkingTransaction.create! parking_transaction_params
  end

end
