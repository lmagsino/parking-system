class ParkingTransactionsController < ApplicationController

  def index
    @parking_transactions = ParkingTransaction.all.ordered_by_created_at

    render_json @parking_transactions, :ok
  end

end
