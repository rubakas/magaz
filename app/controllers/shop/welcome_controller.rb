class Shop::WelcomeController < ApplicationController
  def index
    @collections = current_shop.collections
  end
end
