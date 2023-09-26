class FareService
  BUS = 'Bus'.freeze
  ZONE_ONE = 1.freeze
  PRICES = {
    bus: 180,
    outside_zone_one: 200,
    any_two_excluding_zone_one: 225,
    zone_one: 250,
    any_two_including_zone_one: 300,
    three_zones: 320
  }.freeze

  def self.max_fare(means_of_transport)
    means_of_transport == BUS ? PRICES[:bus] : PRICES[:three_zones]
  end

  def self.calculate_refund_fare(start_zones, end_zones)
    common_zones = start_zones & end_zones
    price = if common_zones.any?
              common_zones.all?(ZONE_ONE) ? PRICES[:zone_one] : PRICES[:outside_zone_one]
            else
              zones = closest_path(start_zones, end_zones)
              if (zones.max - zones.min) == 1
                zones.include?(ZONE_ONE) ? PRICES[:any_two_including_zone_one] : PRICES[:any_two_excluding_zone_one]
              else
                PRICES[:three_zones]
              end
            end

    PRICES[:three_zones] - price
  end

  private

  def self.closest_path(start_zones, end_zones)
    closest = [start_zones.min, end_zones.min]
    start_zones.each do |zone|
      end_zones.each do |end_zone|
        closest = [zone, end_zone] if (zone - end_zone).abs < (closest.max - closest.min)
      end
    end

    closest
  end
end
