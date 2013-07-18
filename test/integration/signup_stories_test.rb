require 'test_helper'

class SignupStoriesTest < ActionDispatch::IntegrationTest  
  test "root signup success" do
  	visit '/'
  	assert page.has_content?('Welcome')

  	fill_in 'Your shop name', with: 'Example'
  	fill_in 'Email address', with: 'admin@example.com'
  	fill_in 'Password', with: 'password'
  	click_button 'Create your shop now'

  	assert page.has_content?('Welcome')
  end

  test "root signup failure" do
  	skip
  end

  test "registrations signup success" do
  	skip
  end

  test "registrations signup failure" do
  	skip
  end
end
