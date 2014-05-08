class WelcomeController < ApplicationController
  def index
    @shop = MagazCore::Shop.new
  end

  def goodbye
  end
end
