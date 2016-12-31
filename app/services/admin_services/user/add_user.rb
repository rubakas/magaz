class AdminServices::User::AddUser
  attr_reader :success, :result, :errors
  alias_method :success?, :success

  def initialize  shop_id:, 
                  params:
    @result = ::User.new(default_params(shop_id))
    @params = params
  end

  def run
    @result.assign_attributes(user_params)
    if @result.valid?(:create_shop)
      @result.save
      @success = true
    else
      @success = false
      @errors = @result.errors
    end
    self
  end

  private

  def user_params
    @params.slice 'first_name',
                  'last_name',
                  'email',
                  'password',
                  'permissions',
                  'account_owner'
  end

  def default_params(shop_id)
    { 'permissions' => nil, 'account_owner' => false , 'shop_id' => shop_id }
  end
end
