require 'test_helper'

class RegistrationsControllerTest < ActionController::TestCase
  setup do
    @registration = create(:shop)
    @default_theme = build(:theme)
    archive_path = ::File.expand_path("#{Rails.root}/test/fixtures/files/valid_theme.zip", __FILE__)
    MagazCore::ThemeServices::ImportFromArchive
      .call(archive_path: archive_path,
            theme: @default_theme,
            theme_attributes: { name: 'Default' })
  end

  test "should create shop" do
    @request.host = HOSTNAME
    assert_difference('MagazCore::Shop.count') do
      post :create, shop: {
        name: 'uniq name',
        email: 'uniq1@example.com',
        password: '1234q'
      }
    end
    assert session[:user_id]
    @request.host = "uniq-name.#{HOSTNAME}"
    assert_redirected_to admin_root_path(host: HOSTNAME, subdomain: 'uniq-name')
  end

end
