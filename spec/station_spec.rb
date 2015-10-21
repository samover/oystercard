require 'station'
describe Station do
  subject {described_class.new(zone: 1, location: "Aldgate")}
  it do expect(subject).to respond_to :zone end
  it do expect(subject).to respond_to :location end
end


array = [  ]
array.each {|index|
  if index % 2 == 0
    Station.new(,)
  end
}

def new_station(zone,location)
  Station.new(zone,location)
end