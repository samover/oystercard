require 'station'
describe Station do
  subject = Station.new("zone", "location")
  it do expect(subject).to respond_to :zone end
  it do expect(subject).to respond_to :location end
end