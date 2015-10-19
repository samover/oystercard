require 'barrier'

describe Barrier do
  let(:card) {double :card}
  before(:each) do
    allow(card).to receive(:activate).and_return(true)
    allow(card).to receive(:deactivate).and_return(false)
  end

  describe "#touch_in" do
    it 'expects touch in to change active status' do
      expect(subject.touch_in(card)).to eq true
    end
  end

  describe "#touch_out" do
    it "expects touch out to change in journey status to false" do
      expect(subject.touch_out(card)).to eq false
    end
  end

end
