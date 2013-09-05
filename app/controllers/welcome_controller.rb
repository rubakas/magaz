class WelcomeController < ApplicationController
  def index
  	@shop = Shop.new
  end

  def goodbye
  end
end
