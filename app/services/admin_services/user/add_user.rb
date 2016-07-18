class AdminServices::User::AddUser
  attr_reader :success
  attr_reader :result
  alias_method :success?, :success

  def initialize(shop_id, params, user = User.new)
    @shop_id = shop_id
    @result = user
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
    permitted_params.merge(default_params) { |_key,v1,_v2| v1 }
  end

  def default_params
    { permissions: nil, account_owner: false , shop_id: @shop_id}
  end

  def permitted_params
    @params.slice(:first_name, :last_name, :email, :password, :permissions, :account_owner)
  end
end
