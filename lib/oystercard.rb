class Oystercard
  attr_reader :balance, :entry_station, :exit_station, :history
  DEFAULT_BALANCE = 0
  MINIMUM_FARE = 1
  LIMIT = 90
  def initialize (balance=DEFAULT_BALANCE)
    @balance = balance
    @in_journey = false
    @entry_station = nil
    @exit_station = nil
    @history = []
  end

  def top_up(num)
    fail "Unable to top up beyond the limit of £#{LIMIT}" if full?(num)
    @balance += num
  end

  def touch_in(station)
    fail "Unable to touch in: insufficient balance" if insufficient_balance?
    # deduct
    journey = {}
    journey[:entry_station] = station 
  end

  def touch_out(station)
    deduct(MINIMUM_FARE)
    @exit_station = station
    journey = {entry_station: @entry_station, exit_station: @exit_station}
    @entry_station = nil
    @history << journey
  end

  def in_journey?
    entry_station ? true : false
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
