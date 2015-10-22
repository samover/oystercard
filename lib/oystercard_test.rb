require_relative 'station'       # => true
require_relative 'journey_test'  # => true

class OystercardTest
  attr_reader :balance, :journey  # => nil

  MINIMUM_FARE = 1     # => 1
  DEFAULT_BALANCE = 0  # => 0
  LIMIT = 90           # => 90

  def initialize (balance = DEFAULT_BALANCE)
    @balance = balance                        # => 90
  end

  def top_up(value)
    fail "Unable to top up beyond the limit of £#{LIMIT}" if full?(value)
    @balance += value
  end

  def touch_in(station, journey = JourneyTest.new)
    # deduct(journey.fare) if in_journey?
    fail "Unable to touch in: insufficient balance" if balance < MINIMUM_FARE  # => nil
    journey.start(station) # journey.entry_station = station
  end

  def touch_out(station)
    journey.end(station) # journey.exit_station = station
    deduct(trip.fare)
    journey.log
  end

  def start_journey(station)
    JourneyTest.new(station)
  end

  def in_journey?
    journey.in_progress?
  end

end

card = OystercardTest.new(90)          # => #<OystercardTest:0x007fcb0183e9f0 @balance=90>
aldgate = Station.new(2, 'aldgate')    # => #<Station:0x007fcb0183e770 @zone=2, @location="aldgate">
victoria = Station.new(2, 'victoria')  # => #<Station:0x007fcb0183e5e0 @zone=2, @location="victoria">

card.touch_in victoria  # => #<Station:0x007fcb0183e5e0 @zone=2, @location="victoria">

card.touch_out aldgate

card.journey
card.history
card.touch_in victoria
card.touch_out aldgate
card.journey
card.journey.history

card.touch_out aldgate
card.journey.history

card.touch_in victoria
card.touch_in victoria
card.journey.history    #

# ~> NoMethodError
# ~> undefined method `end' for nil:NilClass
# ~>
# ~> /Users/samuel/MAKERS/course_challenges/oystercard_thursday/lib/oystercard_test.rb:27:in `touch_out'
# ~> /Users/samuel/MAKERS/course_challenges/oystercard_thursday/lib/oystercard_test.rb:48:in `<main>'
