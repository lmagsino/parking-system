module Calculator
  class Parking < ApplicationService

    OVERNIGHT_HOUR = 24
    SECONDS_IN_HOUR = 3600

    attr_reader :parking_transaction, :parking_slot, :parking_lot



    def initialize parking_transaction
      @parking_transaction = parking_transaction
      @parking_slot = @parking_transaction.parking_slot
      @parking_lot = @parking_slot.parking_lot
    end

    def call
      total_hours = calculate_total_hours

      if apply_flat_rate?(total_hours)
        return parking_lot.flat_rate
      end

      overnight_duration = calculate_overnight_duration total_hours
      continuous_duration =
        calculate_continuous_duration total_hours, overnight_duration

      calculate_total_amount overnight_duration, continuous_duration
    end



    private

    def calculate_total_hours
      start_time = Time.parse @parking_transaction.start_time.to_s
      end_time = Time.parse @parking_transaction.end_time.to_s

      ((end_time - start_time)/SECONDS_IN_HOUR).ceil
    end

    def apply_flat_rate? total_hours
      !parking_transaction.returning && total_hours <= parking_lot.flat_rate_duration
    end

    def calculate_overnight_duration total_hours
      total_hours >= OVERNIGHT_HOUR ? total_hours / OVERNIGHT_HOUR : 0
    end

    def calculate_continuous_duration total_hours, overnight_duration
      if overnight_duration == 0
        continuous =
          @parking_transaction.returning ?
            total_hours :
            (total_hours - @parking_lot.flat_rate_duration)

      else
        continuous = total_hours % OVERNIGHT_HOUR
      end

      continuous
    end

    def get_total_overnight_amount duration
      duration * @parking_lot.overnight_rate
    end

    def get_total_continuous_amount duration
      duration *
        Calculator::ContinuousRate.call(
          @parking_slot.parking_type, @parking_lot
        )
    end

    def get_flat_rate overnight_duration
      return 0 if overnight_duration > 0 || @parking_transaction.returning
      @parking_lot.flat_rate
    end

    def calculate_total_amount overnight_duration, continuous_duration
      get_total_overnight_amount(overnight_duration) +
        get_total_continuous_amount(continuous_duration) +
        get_flat_rate(overnight_duration)
    end

  end
end
