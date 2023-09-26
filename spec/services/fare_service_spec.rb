require_relative '../../app/services/fare_service'

describe FareService do
  describe '#max_fare' do
    subject { FareService.max_fare(means_of_transport) }

    context 'when journey is on a bus' do
      let(:means_of_transport) { 'Bus' }

      it 'returns the cost of a bus ticket' do
        expect(subject).to eq(FareService::PRICES[:bus])
      end
    end

    context 'when journey is on any other thing' do
      let(:means_of_transport) { 'Tube' }

      it 'returns the cost of a three zone ticket' do
        expect(subject).to eq(FareService::PRICES[:three_zones])
      end
    end
  end

  describe '#calculate_refund_fare' do
    subject { FareService.calculate_refund_fare(start_zones, end_zones) }

    context 'when there is an intersection between the zones' do
      let(:start_zones) { [1, 2] }

      context 'when zone_one is only one in the intersection' do
        let(:end_zones) { [1, 4, 5] }

        it 'returns the difference between the three zone price and the zone one price' do
          expect(subject).to eq(FareService::PRICES[:three_zones] - FareService::PRICES[:zone_one])
        end
      end

      context 'when the zone_one is not the only one in the intersection' do
        let(:end_zones) { [1, 2, 4] }

        it 'returns the difference between the three zone price and the outside zone one price' do
          expect(subject).to eq(FareService::PRICES[:three_zones] - FareService::PRICES[:outside_zone_one])
        end
      end
    end

    context 'when there is not an intersection between the zones' do
      context 'when the closest path is one step' do
        let(:end_zones) { [2, 3, 4] }

        context 'when the close path includes the zone one' do
          let(:start_zones) { [1] }

          it 'returns the difference between the three zone price and any two including zone one price' do
            expect(subject).to eq(FareService::PRICES[:three_zones] - FareService::PRICES[:any_two_including_zone_one])
          end
        end

        context 'when the close path does not include the zone one' do
          let(:start_zones) { [5] }

          it 'returns the difference between the three zone price and any two excluding zone one price' do
            expect(subject).to eq(FareService::PRICES[:three_zones] - FareService::PRICES[:any_two_excluding_zone_one])
          end
        end
      end

      context 'when the closest is more than one step' do
        let(:start_zones) { [1, 9] }
        let(:end_zones) { [3, 4] }

        it 'returns 0' do
          expect(subject).to eq(0)
        end
      end
    end
  end
end
