require_relative '../../app/models/user'
require_relative '../../app/presenters/user_presenter'

describe UserPresenter do
  subject { UserPresenter.new(user) }

  let(:user) { User.new(defined_balance) }
  let(:defined_balance) { 27.25 }

  it 'returns the balance as was defined' do
    expect(subject.balance).to eq(defined_balance)
  end
end
