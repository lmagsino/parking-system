module ParkingSlotManager
  class ParkingSlotChecker < ApplicationService

    attr_reader :parking_lot, :parking_types, :entry_point



    def initialize parking_lot, parking_types, entry_point
      @parking_lot = parking_lot
      @parking_types = parking_types
      @entry_point = entry_point
    end

    def call
      available_parking_slots = find_available_parking_slots
      validate_parking_slots available_parking_slots

      sorted_parking_slots = sort_parking_slots available_parking_slots
      sorted_parking_slots.first
    end



    private

    def validate_parking_slots available_parking_slots
      if available_parking_slots.empty?
        raise StandardError, 'Sorry, No available parking slot for now.'
      end
    end

    def find_available_parking_slots
      parking_slots = []

      parking_types.each do |parking_type|
        parking_slots = ParkingSlot.under(parking_lot).parking_type_is(parking_type).available
        break unless parking_slots.empty?
      end

      filtered_parking_slots = []

      entry_point.downto(1) do |point|
        filtered_parking_slots = parking_slots.select { |slot| slot.location[point - 1] }
        break unless filtered_parking_slots.empty?
      end

      filtered_parking_slots
    end

    def sort_parking_slots parking_slots
      parking_slots.sort_by { |slot| [slot.parking_type, slot.location[entry_point - 1]] }
    end

  end
end
