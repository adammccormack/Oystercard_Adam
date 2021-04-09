require 'oystercard'

describe OysterCard do
  subject(:card) { described_class.new }
  let(:entry_station) { double :station }
  let(:exit_station) { double :station }
  let(:journey) {{ entry_station: entry_station , exit_station: exit_station }}

    it 'has a balance of zero' do
      expect(card.balance).to eq(0)
    end

  describe '#top_up' do

    it 'can top up the balance' do
      expect { card.top_up(1) }.to change{ card.balance }.by(1)
    end

    it 'raises an error when maximum balance exceeded' do
      maximum_balance = OysterCard::MAXIMUM_BALANCE
      card.top_up(maximum_balance)
      expect { card.top_up(1) }.to raise_error "Maximum balance of #{maximum_balance} exceeded"
    end
  end

  describe '#deduct' do

    it 'deducts fare' do
      card.top_up(20)
      expect{ card.send(:deduct, 3)  }.to change{ card.balance }.by(-3)
    end
  end

  describe '#journeys' do

    it 'initializes with empty journeys' do
      expect(card.journeys).to be_empty
    end

    it 'stores journeys' do
      card.top_up(10)
      card.touch_in(entry_station)
      card.touch_out(exit_station)
      expect(card.journeys).to include journey
    end

  end

  describe '#touch_in' do

    it 'stores entry station' do
      card.top_up(5)
      card.touch_in(entry_station)
      expect(card.entry_station).to eq(entry_station)
    end

    it 'is initially not in a journey' do
      expect(card).not_to be_in_journey
    end

    it "can touch in" do
      card.top_up(1)
      card.touch_in(entry_station)
      expect(card).to be_in_journey
    end

    it "can touch out" do
      card.top_up(1)
      card.touch_in(entry_station)
      card.touch_out(exit_station)
      expect(card).not_to be_in_journey
    end

    it 'will not touch in if below minimum balance' do
      expect{ card.touch_in(entry_station) }.to raise_error "Insufficient balance to touch in"
    end
  end

  describe '#touch_out' do

    it 'stores exit station' do
      card.top_up(5)
      card.touch_in(entry_station)
      card.touch_out(exit_station)
      expect(card.exit_station).to eq(exit_station)
    end

    it 'deducts fare on touch out' do
      card.top_up(10)
      card.touch_in(entry_station)
      expect{ card.touch_out(exit_station) }.to change{ card.balance }.by(-OysterCard::MINIMUM_BALANCE)

    end

    it 'changes entry station to nil' do
      card.top_up(5)
      card.touch_in(entry_station)
      card.touch_out(exit_station)
      expect(card.entry_station).to eq(nil)
    end


  end
end
