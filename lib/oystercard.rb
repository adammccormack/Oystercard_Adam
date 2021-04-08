class OysterCard
  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1
  
  attr_reader :balance
  attr_accessor :entry_station

  def initialize
    @balance = 0
    @in_journey
  end

  def top_up(amount)
    fail "Maximum balance of #{MAXIMUM_BALANCE} exceeded" if amount + balance > MAXIMUM_BALANCE
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

  def touch_in(station)
    fail "Insufficient balance to touch in" if balance < MINIMUM_BALANCE
    @entry_station = station
  end

  def touch_out
    deduct(MINIMUM_BALANCE)
    @entry_station = nil
  end

  def in_journey?
    !!entry_station # if in journey, entry station == true, else false.
  end
end