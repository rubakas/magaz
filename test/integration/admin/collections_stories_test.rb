require 'test_helper'

class Admin::CollectionsStoriesTest < ActionDispatch::IntegrationTest
  setup do
    login
    @collection = create(:collection, shop: @shop)
    click_link 'Collections'
  end

  test 'collections list' do
    assert page.has_content? 'Collections'
    assert page.has_content? @collection.name
  end

  test 'create collection' do
    click_link 'Add Collection', match: :first
    fill_in 'Name', with: 'Some Collection'
    fill_in 'Description', with: ''
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

  test "handle url" do
    click_link 'Add Collection', match: :first
    fill_in 'Name', with: 'Some Collection'
    fill_in 'Description', with: ''
    fill_in 'Handle', with: 'test-url'
    click_button 'Create Collection'
    assert page.has_content? 'Collection was successfully created.'
    assert current_path == "/admin/collections/test-url"
  end


  test 'create collection failure' do
    click_link 'Add Collection', match: :first
    fill_in 'Name', with: ''
    fill_in 'Description', with: ''
    click_button 'Create Collection'
    assert page.has_content? '1 error prohibited this collection from being saved'
  end

  test 'edit collection' do
    click_link(@collection.name, match: :first)
    fill_in 'Name', with: 'Updated Collection'
    fill_in 'Description', with: 'Updated Collection Description'
    click_button 'Update Collection'
    assert page.has_content? 'Collection was successfully updated.'
  end

  test 'delete collection' do
    click_link('Delete', match: :first)
    assert page.has_content? "You have no collections yet, let's create one!"
  end
end