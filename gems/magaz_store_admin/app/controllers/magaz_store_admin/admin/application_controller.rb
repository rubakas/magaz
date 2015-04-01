module MagazStoreAdmin
  class Admin::ApplicationController < ApplicationController
    include MagazCore::Concerns::CurrentShopAccess
    layout 'admin'
  end
end
