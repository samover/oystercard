require 'station'
describe Station do
  subject {described_class.new(1, "Aldgate")}
  it do expect(subject.zone).to eq 1 end
  it do expect(subject.location).to eq "Aldgate" end
end
#
#
# array = [  ]
# array.each {|index|
#   if index % 2 == 0
#     Station.new(,)
#   end
# }
#
# def new_station(zone,location)
#   Station.new(zone,location)
# end
