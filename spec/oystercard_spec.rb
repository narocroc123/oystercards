require 'oystercard'

describe Oystercard do

  let(:station){ double :station }

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

  # describe '#deduct' do
  #   it 'responds to deduct method' do
  #     oystercard = Oystercard.new
  #     expect(oystercard).to respond_to(:deduct).with(1).argument
  #   end
  #
  #   it 'decreases balance by specified amount' do
  #     oystercard = Oystercard.new
  #     oystercard.top_up(15)
  #     expect{ oystercard.deduct 5 }.to change{ oystercard.balance }.by -5
  #   end
  # end

  describe '#touch_in' do
    it 'when called not initally in a journey' do
      expect(subject).to_not be_in_journey
    end

    it 'can touch in' do
      subject.top_up(5)
      subject.touch_in(station)
      expect(subject).to be_in_journey
    end

    it 'throws error if min balance not reached' do
      minimum = Oystercard::MINIMUM
      expect{ subject.touch_in(station) }.to raise_error "Minimum balance of £#{minimum} not reached"
    end

    it 'remembers entry station on touch in' do
      subject.top_up(5)
      subject.touch_in(station)
      expect(subject.entry_station).to eq(station)
    end
  end

  describe '#touch_out' do
    it 'can touch out' do
      subject.top_up(5)
      subject.touch_in(station)
      subject.touch_out(station)
      expect(subject).to_not be_in_journey
    end

    it 'charges journey on touch out' do
      subject.top_up(10)
      subject.touch_in(station)
      charge = Oystercard::CHARGE
      expect { subject.touch_out(station) }.to change { subject.balance }.by -charge
    end

    it 'forgets station on touch out' do
      subject.top_up(5)
      subject.touch_in(station)
      subject.touch_out(station)
      expect(subject.entry_station).to eq(nil)
    end

    it 'remembers exit station on touch out' do
      subject.top_up(5)
      subject.touch_in(station)
      subject.touch_out(station)
      expect(subject.exit_station).to eq(station)
    end
  end

  it 'should store previous journeys' do
    subject.top_up(15)
    subject.touch_in(station)
    subject.touch_out(station)
    expect{subject.touch_in(station)}.to change{:journey_history}.to include(station)
  end
end
