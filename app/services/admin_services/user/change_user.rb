class AdminServices::User::ChangeUser
  attr_reader :success
  attr_reader :result
  alias_method :success?, :success

  def initialize(id:, shop_id:, params:)
    @result = Shop.find(shop_id).users.find(id)
    @params = params
  end

  def run
    @success = @result.update_attributes(user_params)
    self
  end

  private

  def user_params
    @params.slice(:first_name, :last_name, :email, :password, :permissions, :account_owner)
  end
end
