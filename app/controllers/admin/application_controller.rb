class Admin::ApplicationController < ApplicationController
  include Concerns::CurrentShopAccess
  layout 'admin/admin'
end
