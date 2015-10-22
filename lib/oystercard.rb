require_relative 'journey'  # => true
require_relative 'station'  # => true

class Oystercard
  attr_reader :balance, :history, :journey  # => nil

  MINIMUM_FARE = 1     # => 1
  DEFAULT_BALANCE = 0  # => 0
  LIMIT = 90           # => 90

  def initialize (balance = DEFAULT_BALANCE, journey = Journey.new)
    @balance = balance                                               # => 90
    @journey = journey                                               # => #<Journey:0x007fdaac021988>
    @history = []                                                    # => []
  end

  def top_up(value)
    fail "Unable to top up beyond the limit of £#{LIMIT}" if balance + value > LIMIT
    @balance += value
  end

  def touch_in(station)
    touch_out(nil) if in_journey?                                              # => nil, nil, nil, nil
    fail "Unable to touch in: insufficient balance" if balance < MINIMUM_FARE  # => nil, nil, nil, nil
    journey.touch_in(station)                                                  # => ["victoria", 2], ["victoria", 2], ["victoria", 2], ["victoria", 2]
  end

  def touch_out(station)
    journey.touch_out(station)  # => ["aldgate", 2], ["aldgate", 2], ["aldgate", 2], nil
    deduct(journey.fare)        # => 89, 88, 82, 76
    history << journey.dup      # => [#<Journey:0x007fdaac020628 @entry_station=["victoria", 2], @exit_station=["aldgate", 2]>], [#<Journey:0x007fdaac020628 @entry_station=["victoria", 2], @exit_station=["aldgate", 2]>, #<Journey:0x007fdaac01bb50 @entry_station=["victoria", 2], @exit_station=["aldgate", 2]>], [#<Journey:0x007fdaac020628 @entry_station=["victoria", 2], @exit_station=["aldgate", 2]>, #<Journey:0x007fdaac01bb50 @entry_station=["victoria", 2], @exit_station=["aldgate", 2]>, #<Journey:0x007fdaac01b1c8 @entry_station=nil, @exit_station=["aldgate", 2]>], [#<Journey:0x007fdaac020628 @entry_station=["victoria", 2], @exit_station=["aldgate", 2]>, #<Journey:0x007fdaac01bb50 @entry_station=["victoria", 2], @exit_station=["aldgate", 2]>, #<Journey:0x007fdaac01b1c8 @entry_station=nil, @exit_station=["aldgate", 2]>, #<Journey:0x007fdaac01a2f0 @entry_station=["victoria", 2], @exit_station=nil>]
    journey.reset               # => nil, nil, nil, nil
  end

  def in_journey?
    journey.in_progress?  # => false, false, false, true
  end

private              # => Oystercard
  def deduct(num)
    @balance -= num  # => 89, 88, 82, 76
  end
end

card = Oystercard.new(90)              # => #<Oystercard:0x007fdaac0219b0 @balance=90, @journey=#<Journey:0x007fdaac021988>, @history=[]>
aldgate = Station.new(2, 'aldgate')    # => #<Station:0x007fdaac0214d8 @zone=2, @location="aldgate">
victoria = Station.new(2, 'victoria')  # => #<Station:0x007fdaac021348 @zone=2, @location="victoria">

card.journey  # => #<Journey:0x007fdaac021988>
card.history  # => []

card.touch_in victoria  # => ["victoria", 2]

card.journey  # => #<Journey:0x007fdaac021988 @entry_station=["victoria", 2]>
card.history  # => []

card.touch_out aldgate  # => nil

card.journey            # => #<Journey:0x007fdaac021988 @entry_station=nil, @exit_station=nil>
card.history            # => [#<Journey:0x007fdaac020628 @entry_station=["victoria", 2], @exit_station=["aldgate", 2]>]
card.touch_in victoria  # => ["victoria", 2]
card.touch_out aldgate  # => nil
card.history            # => [#<Journey:0x007fdaac020628 @entry_station=["victoria", 2], @exit_station=["aldgate", 2]>, #<Journey:0x007fdaac01bb50 @entry_station=["victoria", 2], @exit_station=["aldgate", 2]>]

card.touch_out aldgate  # => nil
card.history            # => [#<Journey:0x007fdaac020628 @entry_station=["victoria", 2], @exit_station=["aldgate", 2]>, #<Journey:0x007fdaac01bb50 @entry_station=["victoria", 2], @exit_station=["aldgate", 2]>, #<Journey:0x007fdaac01b1c8 @entry_station=nil, @exit_station=["aldgate", 2]>]

card.touch_in victoria  # => ["victoria", 2]
card.touch_in victoria  # => ["victoria", 2]
card.history            # => [#<Journey:0x007fdaac020628 @entry_station=["victoria", 2], @exit_station=["aldgate", 2]>, #<Journey:0x007fdaac01bb50 @entry_station=["victoria", 2], @exit_station=["aldgate", 2]>, #<Journey:0x007fdaac01b1c8 @entry_station=nil, @exit_station=["aldgate", 2]>, #<Journey:0x007fdaac01a2f0 @entry_station=["victoria", 2], @exit_station=nil>]
