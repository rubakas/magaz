class WelcomeController < ApplicationController
  def index
    @shop = Shop.new
    @user = @shop.users.new
    @create_service = StoreServices::Create.new(params: {})
  end

  def goodbye
  end
end
