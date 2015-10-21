class Instantiator
  # def initialize(name)
  #   @name = name
  # end

  def new_instance(klass, *init_args)
    klass.new(*init_args)
  end
end

station_in = Instantiator.new

class Station

  attr_reader :zone, :location

  def initialize(zone, location)
    @zone = zone
    @location = location
  end

end

list = [
        {zone: 1, location: "Aldgate"},
        {zone: 2, location: "Angel"},
        {zone: 3, location: "Putney"},
        {zone: 4, location: "Fulham"}
      ]


array_of_stations = list.each.with_object([]) do |station,array|
  array << Station.send(:new, station[:zone], station[:location] )
end





list.each {|station|
  zone = station[:zone].to_i
  location = station[:location].to_s
  p station_in.new_instance(Station, zone, location)
}