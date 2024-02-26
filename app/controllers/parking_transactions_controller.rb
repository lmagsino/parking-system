class ParkingTransactionsController < ApplicationController

  def index
    @parking_transactions = ParkingTransaction.all.ordered_by_created_at
  end

end
