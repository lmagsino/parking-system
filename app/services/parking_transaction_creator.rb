class ParkingTransactionCreator < ApplicationService

  def initialize parking_transaction
    @parking_transaction = parking_transaction
  end

  def call
    ParkingTransaction.create @parking_transaction
  end

end
