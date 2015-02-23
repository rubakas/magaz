class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception
  include MagazCore::Concerns::CurrentShopAccess
  include UrlHelper

  before_filter :set_mailer_url_options

  def set_mailer_url_options
    ActionMailer::Base.default_url_options[:host] = with_subdomain(request.subdomain)
  end

end
