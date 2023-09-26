class UserPresenter
  attr_accessor :user

  def initialize(user)
    @user = user
  end

  def balance
    user.balance.fdiv(100)
  end
end
