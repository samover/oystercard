require 'barrier'

describe Barrier do
  let(:card) {double :card}
  before(:each) do
    allow(card).to recieve(in_journey?).and_return(true, false)
  end

  describe "#touch_in" do
      it 'expects touch in to change active status' do
      expect(subject.touch_in).to eq true
    end
  end

  describe "#touch_out" do
  end
end
