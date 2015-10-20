require 'oystercard'

describe Oystercard do
  let(:station) { double :station }

  it "checks that default balance is zero" do
    subject.balance()
    expect(subject.balance).to eq Oystercard::DEFAULT_BALANCE
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
      subject.top_up(Oystercard::MINIMUM_FARE)
      subject.touch_in(station)
    end

    it "status 'in journey' to be true" do
      expect(subject.in_journey).to eq true
    end

    context "touching in at a particular station" do
      it "will remember the station touched in at" do
        expect(subject.entry_station).to eq station
      end
    end

    context "when touching in with insufficient funds" do
      it "should raise an error" do
        subject.touch_out
        expect{subject.touch_in(station)}.to raise_error "Unable to touch in: insufficient balance"
      end


    end

  end

  describe "#touch_out" do
      before(:each) do
        subject.top_up(2)
        subject.touch_in(station)
      end

        it "status 'in journey' to be false" do
          subject.touch_out
          expect(subject.in_journey).to eq false
        end

      context 'when touching out' do
        it 'deducts the fare' do
          expect{subject.touch_out}.to change{subject.balance}.by -Oystercard::MINIMUM_FARE
        end
      end


  end
end
