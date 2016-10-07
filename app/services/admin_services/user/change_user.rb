class AdminServices::User::ChangeUser
  attr_reader :success, :result, :errors
  alias_method :success?, :success

  def initialize(id:, shop_id:, params:)
    @result = Shop.find(shop_id).users.find(id)
    @params = params
  end

  def run
    @result.assign_attributes(user_params)
    if @result.valid?(:create_shop) && @result.valid?(:invite)
      @success = true
      @result.save
    else
      @success = false
      @errors = @result.errors
    end
    self
  end

  private

  def user_params
    @params.slice(:first_name, :last_name, :email, :password, :permissions, :account_owner)
  end
end
