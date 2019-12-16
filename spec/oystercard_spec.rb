require 'oystercard'

describe Oystercard do
  it 'responds to instance of oystercard' do
    oystercard = Oystercard.new
    expect(oystercard).to be_kind_of Oystercard
  end

  describe '#balance' do
    it 'responds to balance method' do
      oystercard = Oystercard.new
      expect(oystercard).to respond_to(:balance)
    end
  end
end
