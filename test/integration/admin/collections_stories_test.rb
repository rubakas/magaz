require 'test_helper'

class Admin::CollectionsStoriesTest < ActionDispatch::IntegrationTest
  setup do 
    login_as shop_name: 'Example',
      email: 'admin@example.com',
      password: 'password'
    click_link 'Collections'
  end

  test 'collections list' do
    skip
  end

  test 'create collection' do
    skip
  end

  test 'create collection failure' do
    skip
  end

  test 'edit collection' do
    skip
  end

  test 'delete collection' do
    skip
  end
end