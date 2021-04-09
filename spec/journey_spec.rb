require 'journey'

describe Journey do

let(:entry_station) {double :station}
let(:exit_station) {double :station}
  let(:journey_list) {{ entry_station: entry_station , exit_station: exit_station }}
subject(:journey) { described_class.new }

  it "logs start of journey" do
    journey.start_journey(entry_station)
    expect(journey.entry_station).to eq(entry_station)
  end

  it "ends" do
    journey.end_journey(exit_station)
    expect(journey.exit_station).to eq(exit_station)
  end

  it 'records journey' do
    journey.start_journey(entry_station)
    journey.end_journey(exit_station)
    journey.record_journey
    expect(journey_list).to eq(journey_list)
  end

  it 'checks if in journey' do
    journey.start_journey(entry_station)
    expect(journey.in_journey?).to eq(true)
  end

end
