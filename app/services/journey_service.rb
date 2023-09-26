require_relative 'fare_service'

class JourneyService
  attr_accessor :start_point, :end_point, :means_of_transport, :user

  def initialize(start_point, end_point, means_of_transport, user)
    @start_point = start_point
    @end_point = end_point
    @means_of_transport = means_of_transport
    @user = user
  end

  def start
    charge_journey
  end

  def end(swipe_out = false)
    return if !swipe_out || means_of_transport == FareService::BUS

    partial_refund_journey
  end

  private

  def charge_journey
    descount = FareService.max_fare(means_of_transport)

    raise 'User does not have enough balance' if user.balance < descount

    user.balance -= descount
  end

  def partial_refund_journey
    refund = FareService.calculate_refund_fare(start_point.zones, end_point.zones)
    user.balance += refund
  end
end
