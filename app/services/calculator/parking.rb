module Calculator
  class Parking < ApplicationService

    OVERNIGHT_HOUR = 24
    SECONDS_IN_HOUR = 3600



    def initialize parking_transaction
      @parking_transaction = parking_transaction
      @parking_slot = @parking_transaction.parking_slot
      @parking_lot = @parking_slot.parking_lot
    end

    def call
      total_hours = get_total_hours

      if !@parking_transaction.returning &&
        (total_hours <= @parking_lot.flat_rate_duration)

        return @parking_lot.flat_rate
      end

      overnight_duration = get_overnight_duration total_hours
      continuous_duration =
        get_continuous_duration total_hours, overnight_duration

      get_total_amount overnight_duration, continuous_duration
    end



    private

    def get_total_hours
      start_time = Time.parse @parking_transaction.start_time.to_s
      end_time = Time.parse @parking_transaction.end_time.to_s

      total = (end_time - start_time)/SECONDS_IN_HOUR
      total.ceil
    end

    def get_overnight_duration total_hours
      return 0 if total_hours < OVERNIGHT_HOUR
      total_hours / OVERNIGHT_HOUR
    end

    def get_continuous_duration total_hours, overnight_duration
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

    def get_total_amount overnight_duration, continuous_duration
      get_total_overnight_amount(overnight_duration) +
        get_total_continuous_amount(continuous_duration) +
        get_flat_rate(overnight_duration)
    end

  end
end
