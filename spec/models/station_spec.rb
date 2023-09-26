require_relative '../../app/models/station'

describe Station do
  let(:name) { "Earl’s Court" }
  let(:zones) { [1, 2] }

  subject { Station.new(name, zones) }

  context 'when stations info is valid' do
    it 'initializes with a valid information' do
      expect { subject }.not_to raise_error
    end
  end

  context 'when name is not a string' do
    let(:name) { 21434525 }

    it 'raises an error' do
      expect { subject }.to raise_error('Name should be a string and not nil')
    end
  end

  context 'when name is nil' do
    let(:name) { nil }

    it 'raises an error' do
      expect { subject }.to raise_error('Name should be a string and not nil')
    end
  end

  context 'when zones is not an array' do
    let(:zones) { 'CodeChallenge' }

    it 'raises an error' do
      expect { subject }.to raise_error('Zones should be an Array of Integers and not empty')
    end
  end

  context 'when zones is not an array of integers' do
    let(:zones) { ['CodeChallenge'] }

    it 'raises an error' do
      expect { subject }.to raise_error('Zones should be an Array of Integers and not empty')
    end
  end

  context 'when zones is empty' do
    let(:zones) { [] }

    it 'raises an error' do
      expect { subject }.to raise_error('Zones should be an Array of Integers and not empty')
    end
  end
end
