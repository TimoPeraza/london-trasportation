require_relative 'models/user'
require_relative 'models/station'
require_relative 'services/journey_service'
require_relative 'presenters/user_presenter'

def data_set
  @user = User.new(30.0)

  @holborn = Station.new('Holborn', [1])
  @chelsea = Station.new('Chelsea', [1])
  @earls_court = Station.new("Earl's Court", [1, 2])
  @wimbledon = Station.new('Wimbledon', [3])
  @hammersmith = Station.new('Hammersmith', [2])
end

def journey_from_holborn_to_wimbledon
  puts "Holborn to Earl's Court"
  puts "User balance: #{format('%.2f', user_presenter_balance(@user))} \n"
  first_journey = JourneyService.new(@holborn, @earls_court, 'Tube', @user)
  first_journey.start
  puts "User balance after start: #{format('%.2f', user_presenter_balance(@user))} \n"
  first_journey.end(true)
  puts "User balance after end: #{format('%.2f', user_presenter_balance(@user))} \n"

  puts "Earl's Court to Chelsea"
  puts "User balance: #{format('%.2f', user_presenter_balance(@user))} \n"
  second_journey = JourneyService.new(@earls_court, @chelsea, 'Bus', @user)
  second_journey.start
  puts "User balance after start: #{format('%.2f', user_presenter_balance(@user))} \n"
  second_journey.end
  puts "User balance after end: #{format('%.2f', user_presenter_balance(@user))} \n"

  puts "Chelsea to Wimbledon"
  puts "User balance: #{format('%.2f', user_presenter_balance(@user))} \n"
  third_journey = JourneyService.new(@chelsea, @wimbledon, 'Tube', @user)
  third_journey.start
  puts "User balance after start: #{format('%.2f', user_presenter_balance(@user))} \n"
  third_journey.end(true)
  puts "User balance after end: #{format('%.2f', user_presenter_balance(@user))} \n"
end

def user_presenter_balance(user)
  UserPresenter.new(user).balance
end

data_set
journey_from_holborn_to_wimbledon
