require 'journey'

describe Journey do

 let(:station) { double :station }

  describe "#touch_in" do
   it "should return entry station" do
    expect(subject.touch_in(station)).to eq station
   end
  end

  describe "#touch_out" do
    it "should return exit station" do
      expect(subject.touch_out(station)).to eq station
    end

  end

  describe "#fare" do
    context "when journey is successfully completed" do
      before do
        subject.touch_in(station)
        subject.touch_out(station)
      end
      it "charges default fare" do
        expect(subject.fare).to eq Journey::MINIMUM_FARE
      end
    end
  end

  describe "#complete?" do
    context "when touching in and touching out is successful"
      before do
        subject.touch_in(station)
        subject.touch_out(station)
      end
      it "will return true" do
        expect(subject.complete?).to eq true
      end
  end

end
