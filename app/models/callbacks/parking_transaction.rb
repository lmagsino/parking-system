module Callbacks
  module ParkingTransaction

    def occupy_parking_slot
      self.parking_slot.occupy
    end

    def reoccupy_parking_slot
      self.parking_slot.occupy
      self.end_time = nil
      self.paid_amount = self.total_amount
    end

    def release_parking_slot
      self.parking_slot.release
    end

    def compute_amount
      self.paid_amount = (self.paid_amount && self.paid_amount > 0) ? self.paid_amount : 0
      self.total_amount = Calculator::Parking.call self
      self.amount = self.total_amount - self.paid_amount
    end

  end
end
