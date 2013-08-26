require 'test_helper'

class Admin::CollectionsStoriesTest < ActionDispatch::IntegrationTest
  setup do 
    login_as shop_name: 'Example',
      email: 'admin@example.com',
      password: 'password'
    click_link 'Collections'
  end

  test 'collections list' do
    assert page.has_content? 'Collections'
    assert page.has_content? 'Collection 1'
  end

  test 'create collection' do
    click_link 'New Collection'
    fill_in 'Name', with: 'Some Collection'
    fill_in 'Description', with: 'Some Collection Description'
    click_button 'Create Collection'
    assert page.has_content? 'Collection was successfully created.'
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