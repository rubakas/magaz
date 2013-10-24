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
    click_link 'Add Collection', match: :first
    fill_in 'Name', with: 'Some Collection'
    fill_in 'Description', with: 'Some Collection Description'
    click_button 'Create Collection'
    assert page.has_content? 'Collection was successfully created.'
  end

  test 'create collection - with automatic product conditions' do
    # collection rule consisting of
    # rule-column
    # rule-relation
    # rule-value
    skip
  end


  test 'create collection failure' do
    click_link 'Add Collection', match: :first
    fill_in 'Name', with: ''
    fill_in 'Description', with: ''
    click_button 'Create Collection'
    assert page.has_content? '2 errors prohibited this collection from being saved'
  end

  test 'edit collection' do
    click_link('Show', match: :first)
    fill_in 'Name', with: 'Updated Collection'
    fill_in 'Description', with: 'Updated Collection Description'
    click_button 'Update Collection'
    assert page.has_content? 'Collection was successfully updated.'
  end

  test 'delete collection' do
    click_link('Destroy', match: :first)
    refute page.has_content? 'Collection 1'
  end
end