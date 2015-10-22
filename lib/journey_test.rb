class JourneyTest

  MINIMUM_FARE = 1                                       # => 1
  MAXIMUM_FARE = 6                                       # => 6
  attr_accessor :entry_station, :exit_station, :history  # => nil

  def initialize
    @history = []
  end

  def start(station)
    @entry_station = station
  end

  def end(station)
    @exit_station = station
  end

  def fare
    return MAXIMUM_FARE if entry_station.nil? || exit_station.nil?
    MINIMUM_FARE
  end

  def log
    history << {entry_station => exit_station}
  end

  def reset
    @entry_station = nil
    @exit_station = nil
  end

  def in_progress?
    @entry_station != nil
  end



end
