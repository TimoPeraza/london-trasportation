require_relative '../../app/services/journey_service'
require_relative '../../app/models/user'
require_relative '../../app/models/station'
require 'byebug'

describe JourneyService do
  subject { JourneyService.new(start_station, end_station, means_of_transport, user) }

  let(:start_station) { Station.new('Holborn', [1]) }
  let(:end_station) { Station.new('Hammersmith', [2]) }
  let(:means_of_transport) { 'Tube' }
  let(:user) { User.new(30.0) }

  describe '#start' do
    context 'when user has enough balance to do the journey' do
      it 'charges the maximum fare' do
        expect { subject.start }.to change { user.balance }.from(3000).to(3000 - FareService::PRICES[:three_zones])
      end

      context 'when the journey is on a bus' do
        let(:means_of_transport) { 'Bus' }

        it 'charges the bus fare' do
          expect { subject.start }.to change { user.balance }.from(3000).to(3000 - FareService::PRICES[:bus])
        end
      end
    end

    context 'when user has not enough balance to do the journey' do
      let(:user) { User.new(1.0) }

      it 'raises an error' do
        expect { subject.start }.to raise_error('User does not have enough balance')
      end
    end
  end

  describe '#end' do
    let(:swipe_out) { true }

    before do
      user.balance = user.balance - FareService::PRICES[:three_zones]
    end

    context 'when user swipes out' do
      it 'refunds the price difference of the journey' do
        expect { subject.end(swipe_out) }.to change { user.balance }.from(3000 - FareService::PRICES[:three_zones])
                                                                    .to(3000 - FareService::PRICES[:any_two_including_zone_one])
      end
    end

    context 'when user does not swipe out' do
      it 'does not do any refund' do
        expect { subject.end }.not_to change { user.balance }
      end
    end

    context 'when journey is on a bus' do
      let(:means_of_transport) { 'Bus' }

      before do
        user.balance = user.balance - FareService::PRICES[:bus]
      end

      it 'does not do any refunds' do
        expect { subject.end }.not_to change { user.balance }
        expect { subject.end(swipe_out) }.not_to change { user.balance }
      end
    end
  end
end
