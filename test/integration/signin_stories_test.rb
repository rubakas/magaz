require 'test_helper'

class SigninStoriesTest < ActionDispatch::IntegrationTest
  setup do
    use_host HOSTNAME
    @shop2 = create(:shop, name: 'example2', subdomain: 'example2')
    @user2 = create(:user, shop: @shop2, first_name: 'First2', last_name: 'Last2', email: 'email2@mail.com', password: 'password2')
  end

  test "sign in redirect" do
    visit '/session'
    assert page.has_content?('Sign in')
  end

  test "wrong user" do
    visit '/'
    assert page.has_content?('Sign in')

    click_link 'Sign in'

    fill_in 'Your shop name', with: @shop.name
    fill_in 'Email address', with: @user2.email
    fill_in 'Password', with: 'password2'

    use_subdomain @shop.subdomain

    click_button 'Sign in'

    assert page.has_content?('Sign in')
    assert page.has_content?('Wrong password or email')

    fill_in 'Email address', with: @user.email
    fill_in 'Password', with: 'password'

    assert page.has_content?('Dashboard')
  end

  test "wrong user for shop" do
    use_subdomain @shop.subdomain
    visit '/admin'
    click_link 'Sign out' if page.has_content?('Sign out')

    visit '/admin'
    assert page.has_content?('Sign in')

    fill_in 'Email address', with: @user2.email
    fill_in 'Password', with: 'password2'

    click_button 'Sign in'

    assert page.has_content?('Sign in')
    assert page.has_content?('Wrong password or email')
  end

  test "sign in success" do
    visit '/'
    assert page.has_content?('Sign in')

    click_link 'Sign in'

    fill_in 'Your shop name', with: @shop.name
    fill_in 'Email address', with: @user.email
    fill_in 'Password', with: 'password'

    use_subdomain @shop.subdomain

    click_button 'Sign in'

    assert page.has_content?('Dashboard')
  end

  test "sign in failure" do
    use_js
    use_host HOSTNAME

    visit '/'
    assert page.has_content?('Sign in')

    click_link 'Sign in'

    fill_in 'Your shop name', with: ''
    fill_in 'Email address', with: ''
    fill_in 'Password', with: ''
    click_button 'Sign in'

    assert page.has_content?('Sign in')
  end

  test "user sign in success" do
    use_subdomain @shop.subdomain
    visit '/admin'
    click_link 'Sign out' if page.has_content?('Sign out')

    visit '/admin'
    assert page.has_content?('Sign in')

    fill_in 'Email address', with: @user.email
    fill_in 'Password', with: 'password'

    click_button 'Sign in'
    assert page.has_content?('Dashboard')
  end

  test 'sign out page' do
    login

    click_link 'Sign out'

    use_host HOSTNAME

    assert page.has_content?('Thank you for using magaz')
  end
end
