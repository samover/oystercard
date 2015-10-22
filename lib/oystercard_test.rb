require_relative 'station'       # => true
require_relative 'journey_test'  # => true

class OystercardTest

    MINIMUM_FARE = 1     # => 1
    DEFAULT_BALANCE = 0  # => 0
    LIMIT = 90           # => 90

  def initialize (balance = DEFAULT_BALANCE)
    @balance = balance                        # => 0
  end

  def top_up(value)
    fail "Unable to top up beyond the limit of £#{LIMIT}" if full?(value)
    @balance += value
  end

  def touch_in(station, journey = JourneyTest.new)
    # deduct(penalty_fare) if in_journey?
    fail "Unable to touch in: insufficient balance" if insufficient_balance?
    journey.start_journey(station) # journey.entry_station = station
  end

  def touch_out(station)
    trip.end(station) # journey.exit_station = station
    deduct(trip.fare)
    trip.log
  end

  def start_journey(station)
    JourneyTest.new(station)
  end

  def in_journey?
    journey.in_progress?  # ~> NameError: undefined local variable or method `journey' for #<OystercardTest:0x007fa07897a548 @balance=0>
  end

end

card = OystercardTest.new              # => #<OystercardTest:0x007fa07897a548 @balance=0>
aldgate = Station.new(2, 'aldgate')    # => #<Station:0x007fa07897a2c8 @zone=2, @location="aldgate">
victoria = Station.new(2, 'victoria')  # => #<Station:0x007fa07897a110 @zone=2, @location="victoria">

card.touch_in victoria

card.journey
card.history

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

# ~> NameError
# ~> undefined local variable or method `journey' for #<OystercardTest:0x007fa07897a548 @balance=0>
# ~>
# ~> /Users/samuel/MAKERS/course_challenges/oystercard_thursday/lib/oystercard_test.rb:36:in `in_journey?'
# ~> /Users/samuel/MAKERS/course_challenges/oystercard_thursday/lib/oystercard_test.rb:20:in `touch_in'
# ~> /Users/samuel/MAKERS/course_challenges/oystercard_thursday/lib/oystercard_test.rb:45:in `<main>'
