class ActionDispatch::IntegrationTest

  setup do
    @shop = create(:shop, name: 'example', subdomain: 'example')
    @user = create(:user, shop: @shop, first_name: 'First', last_name: 'Last', email: 'email@mail.com', password: 'password')
  end

  teardown do
    FileUtils.rm_rf(Dir["#{Rails.root}/test/support/uploads"])
  end

  # private
  module CustomIntegrationDsl
    def use_js
      Capybara.current_driver = Capybara.javascript_driver
    end

    def use_host(host)
      host! host
      Capybara.app_host = "http://" + host + ":" + parallel_capybara_server_port.to_s
      Capybara.default_host = Capybara.app_host
    end

    def use_subdomain(subdomain)
      use_host("#{subdomain}.magaz.local")
    end

    def login
      use_js
      use_host HOSTNAME
      visit '/'
      click_link 'Sign in'
      fill_in 'Your shop name', with: @shop.subdomain
      fill_in 'Email address', with: @user.email
      fill_in 'Password', with: 'password'

      use_subdomain @shop.subdomain
      click_button 'Sign in'
    end
  end

  include CustomIntegrationDsl
end

class ActionController::TestCase

  private

  module CustomControllerDsl
    def session_for_user(user)
      session[:user_id] = user.id
      controller_with_subdomain(user.shop.subdomain)
    end

    def controller_with_subdomain(subdomain)
      request.host = subdomain + '.magaz.local'
    end
  end

  include CustomControllerDsl
end
