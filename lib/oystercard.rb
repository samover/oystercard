require_relative 'journey'  # => true
require_relative 'station'  # => true

class Oystercard
  attr_reader :balance, :history, :journey  # => nil

  MINIMUM_FARE = 1     # => 1
  DEFAULT_BALANCE = 0  # => 0
  LIMIT = 90           # => 90

  def initialize (balance = DEFAULT_BALANCE, journey = Journey.new)
    @balance = balance
    @journey = journey
  end

  def top_up(value)
    fail "Unable to top up beyond the limit of £#{LIMIT}" if balance + value > LIMIT
    @balance += value
  end

  def touch_in(station)
    touch_out(nil) if in_journey?
    fail "Unable to touch in: insufficient balance" if balance < MINIMUM_FARE
    journey.touch_in(station)
  end

  def touch_out(station)
    journey.touch_out(station)
    deduct(journey.fare)
    journey.log
  end

  def in_journey?
    journey.in_progress?
  end

private
  def deduct(num)
    @balance -= num  # => 89, 88, 82, 76
  end
end

card = Oystercard.new(90)              # => #<Oystercard:0x007ff9418191f0 @balance=90, @journey=#<Journey:0x007ff9418191c8 @history=[]>>
aldgate = Station.new(2, 'aldgate')    # => #<Station:0x007ff941818d90 @zone=2, @location="aldgate">
victoria = Station.new(2, 'victoria')  # => #<Station:0x007ff941818c00 @zone=2, @location="victoria">

card.journey  # => #<Journey:0x007ff9418191c8 @history=[]>
card.history  # => nil

card.touch_in victoria  # => ["victoria", 2]

card.journey  # => #<Journey:0x007ff9418191c8 @history=[], @entry_station=["victoria", 2]>
card.history  # => nil

card.touch_out aldgate  # => nil

card.journey            # => #<Journey:0x007ff9418191c8 @history=[{["victoria", 2]=>["aldgate", 2]}], @entry_station=nil, @exit_station=nil>
card.history            # => nil
card.touch_in victoria  # => ["victoria", 2]
card.touch_out aldgate  # => nil
card.journey            # => #<Journey:0x007ff9418191c8 @history=[{["victoria", 2]=>["aldgate", 2]}, {["victoria", 2]=>["aldgate", 2]}], @entry_station=nil, @exit_station=nil>
card.journey.history    # => [{["victoria", 2]=>["aldgate", 2]}, {["victoria", 2]=>["aldgate", 2]}]

card.touch_out aldgate  # => nil
card.journey.history    # => [{["victoria", 2]=>["aldgate", 2]}, {["victoria", 2]=>["aldgate", 2]}, {nil=>["aldgate", 2]}]

card.touch_in victoria  # => ["victoria", 2]
card.touch_in victoria  # => ["victoria", 2]
card.journey.history    # => [{["victoria", 2]=>["aldgate", 2]}, {["victoria", 2]=>["aldgate", 2]}, {nil=>["aldgate", 2]}, {["victoria", 2]=>nil}]
