class AdminServices::User::AddUser
  attr_reader :success
  attr_reader :result
  alias_method :success?, :success

  def initialize(shop_id:, params:)
    @result = User.new(default_params(shop_id))
    @params = params
    @success = false
  end

  def run
    @result.attributes = user_params
    @success = true if @result.save!
    self
  end

  private

  def user_params
    @params.slice(:first_name, :last_name, :email, :password, :permissions, :account_owner)
  end

  def default_params(shop_id)
    { permissions: nil, account_owner: false , shop_id: shop_id }
  end
end
