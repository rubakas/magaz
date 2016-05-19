class WelcomeController < ApplicationController
  def index
    @shop = Shop.new
    @user = @shop.users.new
  end

  def goodbye
  end
end
