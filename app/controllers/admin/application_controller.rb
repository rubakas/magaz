class Admin::ApplicationController < ApplicationController
  include CurrentShopAccess
  layout 'admin'
end
