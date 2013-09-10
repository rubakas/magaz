require 'test_helper'

class SigninStoriesTest < ActionDispatch::IntegrationTest  
  setup do
    set_host HOSTNAME_SITE
  end

  test "sign in redirect" do
    visit '/session'
    assert page.has_content?('Sign in')
  end

  test "sign in success" do
    visit '/'
    assert page.has_content?('Sign in')

    click_link 'Sign in'

    fill_in 'Your shop name', with: 'example'
    fill_in 'Email address', with: 'admin@example.com'
    fill_in 'Password', with: 'password'

    set_host "example.#{HOSTNAME_SHOP}"

    click_button 'Sign in'

    assert page.has_content?('Dashboard')
  end

  test "sign in failure" do
    use_js
    set_host HOSTNAME_SITE

    visit '/'
    assert page.has_content?('Sign in')

    click_link 'Sign in'

    fill_in 'Your shop name', with: ''
    fill_in 'Email address', with: ''
    fill_in 'Password', with: ''
    click_button 'Sign in'

    assert page.has_content?('Sign in')
  end

  test "signin redirect and signup success" do
    skip
  end

  test 'sign out page' do
    login_as shop_name: 'example',
      email: 'admin@example.com',
      password: 'password'

    click_link 'Sign out'

    set_host HOSTNAME_SITE
    
    assert page.has_content?('Thank you for using magaz')
  end
end
