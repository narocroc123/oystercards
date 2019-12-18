class Oystercard
  attr_reader :balance
  attr_accessor :journey
  LIMIT = 90

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
    @journey = true
  end

  def touch_out
    @journey = false
  end

  def in_journey?
    @journey
  end
end
