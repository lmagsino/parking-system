module Callbacks
  module ParkingTransaction

    def occupy_parking_slot
      self.parking_slot.occupy_slot
    end

    def release_parking_slot
      self.parking_slot.release_slot
    end

    def compute_amount
      self.amount = Calculator::Parking.call self
    end

  end
end
