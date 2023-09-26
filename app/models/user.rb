require 'byebug'

class User
  attr_accessor :balance

  def initialize(balance)
    validate(balance)

    @balance = (balance * 100).to_i
  end

  private

  def validate(balance)
    raise 'Balance should be an Integer, not empty and positive' unless (balance.is_a?(Integer) || balance.is_a?(Float)) && balance >= 0
  end
end
