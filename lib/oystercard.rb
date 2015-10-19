class Oystercard
  attr_reader :balance
  DEFAULT_BALANCE = 0
  LIMIT = 90
  def initialize (balance=DEFAULT_BALANCE)
    @balance = balance
  end

  def top_up(num)
    fail "Unable to top up beyond the limit of £#{LIMIT}" if full?(num)
    @balance += num
  end

  private

  def full?(num)
    ((@balance + num) > LIMIT)
  end
end
