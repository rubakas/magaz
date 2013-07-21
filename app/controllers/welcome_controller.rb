class WelcomeController < ApplicationController
  def index
  	@shop=Shop.new
  end
end
