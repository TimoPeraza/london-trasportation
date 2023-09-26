require_relative '../../app/models/user'

describe User do
  subject { User.new(balance) }

  context 'when balance is valid' do
    context 'when is a float' do
      let(:balance) { 30.0 }
  
      it 'initializes correctly' do
        expect { subject }.not_to raise_error
      end

      it 'returns the balance per 100' do
        expect(subject.balance).to eq((balance * 100).to_i)
      end
    end

    context 'when is a integer' do
      let(:balance) { 30 }
  
      it 'initializes correctly' do
        expect { subject }.not_to raise_error
      end

      it 'returns the balance per 100' do
        expect(subject.balance).to eq((balance * 100).to_i)
      end
    end
  end

  context 'when balance is a string' do
    let(:balance) { 'CodeChallenge' }

    it 'raises an error' do
      expect { subject }.to raise_error('Balance should be an Integer, not empty and positive')
    end
  end

  context 'when balance is a negative value' do
    let(:balance) { -1 }

    it 'raises an error' do
      expect { subject }.to raise_error('Balance should be an Integer, not empty and positive')
    end
  end
end
