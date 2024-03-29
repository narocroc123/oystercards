class Oystercard
  attr_reader :balance, :entry_station, :exit_station, :journey_history
  attr_accessor :journey
  LIMIT = 90
  MINIMUM = 1
  CHARGE = 1.5

  def initialize
    @balance = 0
    @journey = false
    @entry_station
    @exit_station
    @journey_hash = {}
    @journey_array = []
  end

  def top_up(amount)
    fail "Limit of £#{LIMIT} Exceeded" if @balance + amount > LIMIT
    @balance += amount
  end

  def touch_in(station)
    raise "Minimum balance of £#{MINIMUM} not reached" if @balance < MINIMUM
    @entry_station = station
    @journey = true
  end

  def touch_out(station)
    deduct(CHARGE)
    @journey = false
    @entry_station = nil
    @exit_station = station
  end

  def in_journey?
    !!entry_station
  end

  private

  def deduct(amount)
    @balance -= amount
  end
end
