require_relative 'oystercard'

class Journey

attr_reader :entry_station, :exit_station, :journey_list

  def initialize
    @record_journey
    @journey_list = []
    @entry_station = nil
  end

  def start_journey(station)
      @entry_station = station
  end

  def end_journey(station)
      @exit_station = station
      record_journey
  end

  def in_journey?
    !!entry_station # if in journey, entry station == true, else false.
  end

  def record_journey
    @journey_list << { entry_station: entry_station , exit_station: exit_station }
  end

end
