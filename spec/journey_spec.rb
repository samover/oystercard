require 'journey'

describe Journey do

 let(:station) { double :station }

  context "#touch_in" do
    it "should return entry station" do
      expect(subject.touch_in(station)).to eq station
    end
  end

  context "#touch_out" do
    it "should return exit station" do
      expect(subject.touch_out(station)).to eq station
    end
  end

  context "#fare" do
    it "charges default fare when journey complete" do
      subject.touch_in(station)
      subject.touch_out(station)
      expect(subject.fare).to eq Journey::MINIMUM_FARE
    end
    it "returns maximum fare when journey failed to touch out" do

    end
    it "returns maximum fare when journey failed to touch in" do

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

  context "when touching out at a particular station" do
    # it "will remember the station touched out at" do
    #   expect(subject.journey[:exit_station]).to eq station2
    # end

    it "will return a journey record" do
      expect(subject.history.last).to eq journey
    end
  end

end
