module MagazStoreAdmin
  class ApplicationController < ActionController::Base
    include MagazCore::Concerns::CurrentShopAccess
    layout 'admin'
    require Rails.root.join("lib/custom_public_exceptions")
    config.exceptions_app = CustomPublicExceptions.new(Rails.public_path)
  end
end
