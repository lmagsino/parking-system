module Calculator
  class ContinuousRate < ApplicationService

    def initialize parking_type, parking_lot
      @parking_type = parking_type
      @parking_lot = parking_lot
    end

    def call

      case @parking_type
      when 'small'
        @parking_lot.small_parking_rate
      when 'medium'
        @parking_lot.medium_parking_rate
      when 'large'
        @parking_lot.large_parking_rate
      end

    end

  end
end
