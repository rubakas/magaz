module MagazStoreAdmin
  class ApplicationController < ActionController::Base
    include MagazCore::Concerns::CurrentShopAccess
  end
end
