class Oystercard
  attr_reader :balance, :in_journey, :entry_station
  DEFAULT_BALANCE = 0
  MINIMUM_FARE = 1
  LIMIT = 90
  def initialize (balance=DEFAULT_BALANCE)
    @balance = balance
    @in_journey = false
    @entry_station = nil
  end

  def top_up(num)
    fail "Unable to top up beyond the limit of £#{LIMIT}" if full?(num)
    @balance += num
  end

  def touch_in(station)
    fail "Unable to touch in: insufficient balance" if insufficient_balance?
    # deduct
    @in_journey = true
    @entry_station = station
  end

  def touch_out
    deduct(MINIMUM_FARE)
    @in_journey = false
  end

private

  def full?(num)
    ((@balance + num) > LIMIT)
  end

  def insufficient_balance?
    @balance < MINIMUM_FARE
  end

  def deduct(num)
    @balance -= num
  end

end
