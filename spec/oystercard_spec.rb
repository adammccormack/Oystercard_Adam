require 'oystercard'

describe OysterCard do
    it 'has a balance of zero' do
      expect(subject.balance).to eq(0)
    end

  describe '#top_up' do

    it 'can top up the balance' do
      expect { subject.top_up(1) }.to change{ subject.balance }.by(1)
    end

    it 'raises an error when maximum balance exceeded' do
      maximum_balance = OysterCard::MAXIMUM_BALANCE
      subject.top_up(maximum_balance)
      expect { subject.top_up(1) }.to raise_error "Maximum balance of #{maximum_balance} exceeded"
    end

  describe '#deduct' do

    it 'deducts fare' do
      subject.top_up(20)
      expect{ subject.deduct(3) }.to change{ subject.balance }.by(-3)
    end

  describe '#touch_in' do

    it 'is initially not in a journey' do
      expect(subject).not_to be_in_journey
    end

    it "can touch in" do
      subject.touch_in
      expect(subject).to be_in_journey
    end

    it "can touch out" do
      subject.touch_in
      subject.touch_out
      expect(subject).not_to be_in_journey
    end

  end
  end
  end
end
