class OysterCard
  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1

  attr_reader :balance
  attr_accessor :entry_station, :exit_station, :journeys

  def initialize
    @balance = 0
    @journeys = []
    @entry_station = nil
  end

  def top_up(amount)
    fail "Maximum balance of #{MAXIMUM_BALANCE} exceeded" if max_limit(amount)
    @balance += amount
  end

  def touch_in(station)
    fail "Insufficient balance to touch in" if min_limit
    @entry_station = station
  end

  def touch_out(station)
    deduct(MINIMUM_BALANCE)
    @exit_station = station
    log_journey
    @entry_station = nil
  end

  def in_journey?
    !!entry_station # if in journey, entry station == true, else false.
  end

  def log_journey
    @journeys << { entry_station: entry_station , exit_station: exit_station }
  end

  private

  def max_limit(amount)
    (amount + @balance) > MAXIMUM_BALANCE
  end

  def min_limit
    balance < MINIMUM_BALANCE
  end

  def deduct(amount)
    @balance -= amount
  end

end
