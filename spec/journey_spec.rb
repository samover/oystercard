require 'journey'

describe Journey do

 let(:station) { double(:station, location: :location, zone: :zone)}

  context "#touch_in" do
    it "should return entry station" do
      expect(subject.touch_in(station)).to eq [station.location, station.zone]
    end
  end

  context "#touch_out" do
    it "should return exit station" do
      expect(subject.touch_out(station)).to eq [station.location, station.zone]
    end
  end

  context "#fare" do
    it "charges default fare when journey complete" do
      subject.touch_in(station)
      subject.touch_out(station)
      expect(subject.fare).to eq described_class::MINIMUM_FARE
    end

    it "returns maximum fare when journey failed to touch out" do
      subject.touch_in(station)
      expect(subject.fare).to eq described_class::MAXIMUM_FARE
    end

    it "returns maximum fare when journey failed to touch in" do
      subject.touch_out(station)
      expect(subject.fare).to eq described_class::MAXIMUM_FARE
    end
  end
end
