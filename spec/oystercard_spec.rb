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
  end
end