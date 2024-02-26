module Callbacks
  module ParkingTransaction

    def occupy_parking_slot
      self.parking_slot.occupy
    end

    def release_parking_slot
      self.parking_slot.release
    end

    def compute_amount
      self.amount = Calculator::Parking.call self
    end

  end
end
