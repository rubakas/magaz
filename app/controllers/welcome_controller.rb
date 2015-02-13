class WelcomeController < ApplicationController
  def index
    @shop = MagazCore::Shop.new
    @user = @shop.users.new
  end

  def goodbye
  end
end
