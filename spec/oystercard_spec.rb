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

  describe '#top_up' do
    it 'responds to top_up method' do
      oystercard = Oystercard.new
      expect(oystercard).to respond_to(:top_up).with(1).argument
    end

    it 'increases balance by specified amount' do
      oystercard = Oystercard.new
      expect{ oystercard.top_up 5 }.to change{ oystercard.balance }.by 5
    end

    it 'throws error if limit is exceeded' do
      oystercard = Oystercard.new
      limit = Oystercard::LIMIT
      oystercard.top_up(limit)
      expect{ oystercard.top_up(1) }.to raise_error "Limit of £#{limit} Exceeded"
    end
  end

  describe '#deduct' do
    it 'responds to deduct method' do
      oystercard = Oystercard.new
      expect(oystercard).to respond_to(:deduct).with(1).argument
    end

    it 'decreases balance by specified amount' do
      oystercard = Oystercard.new
      oystercard.top_up(15)
      expect{ oystercard.deduct 5 }.to change{ oystercard.balance }.by -5
    end
  end
end
