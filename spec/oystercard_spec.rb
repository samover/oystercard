require 'oystercard'

describe Oystercard do

  let(:station) { double :station }
  let(:journey) { double :journey}

  it "checks that default balance is zero" do
    subject.balance()
    expect(subject.balance).to eq Oystercard::DEFAULT_BALANCE
  end

  describe "#in_journey?" do

    context "when touching in" do
        xit "returns station (true)" do
          subject.top_up(Oystercard::MINIMUM_FARE)
          subject.touch_in(station)
          expect(subject.in_journey?).to eq true
        end

      end

    context "when touching out" do
        xit "returns not in journey" do
          subject.touch_out(station)
          expect(subject.in_journey?).to eq false
        end
    end

  end


  describe "#top_up" do
    it "allows for balance to be topped up" do
      2.times { subject.top_up(10) }
      expect(subject.balance).to eq 20
    end

    context "when topping up beyond the limit" do
      it "will not allow the user to top up" do
        subject.top_up(Oystercard::LIMIT)
        expect{subject.top_up(1)}.to raise_error("Unable to top up beyond the limit of £#{Oystercard::LIMIT}")
      end
    end
  end

  describe "#touch_in" do
    before(:each) do
      allow(station).to receive(:zone).and_return("zone")
      allow(station).to receive(:location).and_return("location")
      subject.top_up(Oystercard::MINIMUM_FARE)
      subject.touch_in(station)
    end
  #
  #   # context "touching in at a particular station" do
  #   #   it "will remember the station touched in at" do
  #   #     expect(subject.journey[:entry_station]).to eq station
  #   #   end
  #
  #     # it "will return the station zone" do
  #     #   expect((subject).journey[:entry_station].zone).to eq "zone"
  #     # end
  #
  #     # it "will return the station location" do
  #     #   expect((subject).journey[:entry_station].location).to eq "location"
  #     # end
  #
  #   # end

    context "when touching in with insufficient funds" do
      it "should raise an error" do
        subject.touch_out(station)
        expect{subject.touch_in(station)}.to raise_error "Unable to touch in: insufficient balance"
      end
    end

  end

  describe "#touch_out" do

    let(:station2) {double(:station)}

      before(:each) do
        subject.top_up(2)
        subject.touch_in(station)
        subject.touch_out(station2)
      end
        #
        # it "resets entry station to nil" do
        #   expect(subject.journey[:entry_station]).to eq nil
        # end

      context 'when touching out' do
        it 'deducts the fare' do
          expect{subject.touch_out(station2)}.to change{subject.balance}.by -Oystercard::MINIMUM_FARE
        end
      end

      # context "when touching out at a particular station" do
      #   # it "will remember the station touched out at" do
      #   #   expect(subject.journey[:exit_station]).to eq station2
      #   # end
      #
      #   it "will return a journey record" do
      #     expect(subject.history.last).to eq journey
      #   end
      # end

  end
end
