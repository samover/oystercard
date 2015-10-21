class Oystercard
  attr_reader :balance, :history, :journey
  DEFAULT_BALANCE = 0
  MINIMUM_FARE = 1
  LIMIT = 90
  def initialize (balance=DEFAULT_BALANCE)
    @balance = balance
    @history = []
    @journey = {}
  end

  def top_up(num)
    fail "Unable to top up beyond the limit of £#{LIMIT}" if full?(num)
    @balance += num
  end

  def touch_in(station)
    fail "Unable to touch in: insufficient balance" if insufficient_balance?
    @journey[:entry_station] = station
  end

  def touch_out(station)
    deduct(MINIMUM_FARE)
    @journey[:exit_station] = station
    @history << @journey.clone
    @journey[:entry_station] = nil
  end

  def in_journey?
    @journey[:entry_station] ? true : false
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
