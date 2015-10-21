class Oystercard
  attr_reader :balance, :history, :journey
  MINIMUM_FARE = 1
  DEFAULT_BALANCE = 0
  LIMIT = 90
  def initialize (balance=DEFAULT_BALANCE)
    @balance = balance
    @history = []
    @journey = nil
  end

  def top_up(num)
    fail "Unable to top up beyond the limit of £#{LIMIT}" if full?(num)
    @balance += num
  end

  def touch_in(station)
    fail "Unable to touch in: insufficient balance" if insufficient_balance?
    @journey = Journey.new
    @journey.touch_in(station)
  end

  def touch_out(station)
    @journey.touch_out(station)
    deduct(@journey.fare)
    @history << @journey
  end

  # def in_journey?
  #   @journey.entry_station ? true : false
  # end

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
