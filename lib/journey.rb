class Journey

  MINIMUM_FARE = 1
  MAXIMUM_FARE = 6
  attr_reader :entry_station, :exit_station

  def initialize
    @entry_station = nil
    @exit_station = nil
  end


  def touch_in(station)
    @entry_station = station
  end

  def touch_out(station)
    @exit_station = station
  end

  def fare
    return MAXIMUM_FARE if entry_station == nil || exit_station == nil
    MINIMUM_FARE
  end

  def reset_entry_station
    @entry_station = nil
  end

  def in_progress?
    @entry_station != nil
  end



end
