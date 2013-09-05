require 'test_helper'

class SigninStoriesTest < ActionDispatch::IntegrationTest  
  test "sign in redirect" do
    visit '/session'
    assert page.has_content?('Sign in')
  end

  test "sign in success" do
    visit '/'
    assert page.has_content?('Sign in')

    click_link 'Sign in'

    fill_in 'Your shop name', with: 'Example'
    fill_in 'Email address', with: 'admin@example.com'
    fill_in 'Password', with: 'password'
    click_button 'Sign in'

    assert page.has_content?('Dashboard')
  end

  test "sign in failure" do
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
  end
end
