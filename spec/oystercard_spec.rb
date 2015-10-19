require 'oystercard'

describe Oystercard do
  it "checks that default balance is zero" do
    subject.balance()
    expect(subject.balance).to eq Oystercard::DEFAULT_BALANCE
  end

  describe "#top_up" do
    it "allows for balance to be topped up" do
      2.times { subject.top_up(10) }
      expect(subject.balance).to eq 20
    end

    it "raises an error when balance surpasses £90" do
      subject.top_up(Oystercard::LIMIT)
      expect{subject.top_up(1)}.to raise_error("Unable to top up beyond the limit of £#{Oystercard::LIMIT}")
    end
  end

    describe "#deduct" do
      it "allows for deduct method" do
        subject.top_up(30)
        expect(subject.deduct(20)).to eq 10
      end
    end

    describe "#in_journey" do
        it "expects active status to change on touching in and out" do
        expect(subject.in_journey?).to eq
      end
    end

end
