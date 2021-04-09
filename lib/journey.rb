require_relative 'oystercard'

class Journey
MIN_FARE = 1
PEN_FARE = 6
attr_reader :entry_station, :exit_station, :journey_list, :completed_journey

  def initialize
    @record_journey
    @journey_list = []
    @entry_station = nil
  end

  def start_journey(station)
      @entry_station = station
  end

  def in_journey?
    !!entry_station # if in journey, entry station == true, else false.
  end

  def end_journey(station)
      @exit_station = station
      record_journey
  end

  def record_journey
    @journey_list << { entry_station: entry_station , exit_station: exit_station }
  end

  def completed_journey?
    return false if (@entry_station == nil && @exit_station != nil) || (@entry_station != nil && @exit_station == nil)
    return true
  end

  def fare
     return PEN_FARE if !completed_journey?
     return MIN_FARE
   end

end
