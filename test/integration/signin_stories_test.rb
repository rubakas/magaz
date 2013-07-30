require 'test_helper'

class SigninStoriesTest < ActionDispatch::IntegrationTest  
  test "signin success" do
    visit '/'
    assert page.has_content?('Sign in')

    click_link 'Sign in'

    fill_in 'Your shop name', with: 'Example'
    fill_in 'Email address', with: 'admin@example.com'
    fill_in 'Password', with: 'password'
    click_button 'Sign in'

    assert page.has_content?('Welcome to dashboard')
  end

  test "signin failure" do
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
  end
end
