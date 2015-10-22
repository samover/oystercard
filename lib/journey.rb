class Journey

  MINIMUM_FARE = 1                                       # => 1
  MAXIMUM_FARE = 6                                       # => 6
  attr_accessor :entry_station, :exit_station, :history  # => nil

  def touch_in(station)
    @entry_station = [station.location, station.zone]
  end

  def touch_out(station)
    @exit_station = station == nil ? station : [station.location, station.zone]
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
