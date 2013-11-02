class ActionDispatch::IntegrationTest 
  # private
  module CustomIntegrationDsl
    def use_js
      Capybara.current_driver = Capybara.javascript_driver
    end

    def set_host (host)
      host! host
      Capybara.app_host = "http://" + host + ":" + parallel_capybara_server_port.to_s
      Capybara.default_host = Capybara.app_host
    end

    def login_as(shop_name:, email:, password:)
      use_js
      set_host HOSTNAME_SITE
      visit '/'
      click_link 'Sign in'
      fill_in 'Your shop name', with: shop_name
      fill_in 'Email address', with: email
      fill_in 'Password', with: password
      
      set_host "#{shop_name}.#{HOSTNAME_SHOP}"
      click_button 'Sign in'
    end
  end

  include CustomIntegrationDsl
end

class ActionController::TestCase
  private
  module CustomControllerDsl
    def session_for_shop(shop)
      session[:user_id] = shop.id
      request.host = shop.subdomain + '.' + HOSTNAME_SHOP
    end
  end

  include CustomControllerDsl
end
