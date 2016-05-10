class ApplicationController < ActionController::Base
  include MagazCore::Concerns::CurrentShopAccess
  layout 'admin'
end
