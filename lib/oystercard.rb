class Oystercard
  attr_reader :balance
  attr_accessor :journey
  LIMIT = 90
  MINIMUM = 1
  CHARGE = 1.5

  def initialize
    @balance = 0
    @journey = false
  end

  def top_up(amount)
    fail "Limit of £#{LIMIT} Exceeded" if @balance + amount > LIMIT
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

  def touch_in
    raise "Minimum balance of £#{MINIMUM} not reached" if @balance < MINIMUM
    @journey = true
  end

  def touch_out
    @balance -= CHARGE
    @journey = false
  end

  def in_journey?
    @journey
  end
end
