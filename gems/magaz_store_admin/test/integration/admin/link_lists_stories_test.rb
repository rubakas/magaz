module MagazStoreAdmin 
require 'test_helper'

class Admin::LinkListsStoriesTest < ActionDispatch::IntegrationTest
  setup do
    login
    @link_list = create(:link_list, shop: @shop, handle: "link-list-handle")
    @link = create(:link, link_list: @link_list)
    click_link 'Navigation'
  end

  test "link_list list" do
    assert page.has_content? 'Link Lists'
    assert page.has_content? @link_list.name
  end

  test "create link_list" do
    click_link 'Add Link List'
    fill_in 'Name', with: 'Some Uniq Link List'
    fill_in 'Handle', with: 'uniq-handle'
    click_button 'Create Link list'
    assert page.has_content? 'Link list was successfully created.'
    assert page.has_content? 'Add Links'
  end

  test "create link_list failure" do
    click_link 'Add Link List'
    fill_in 'Name', with: ''
    click_button 'Create Link list'
    assert page.has_content? '1 error prohibited this link list from being saved'
  end

  test "edit link_list" do
    click_link(@link_list.name, match: :first)
    fill_in 'Name', with: 'Updated Link List'
    click_button 'Update Link list'
    assert page.has_content? 'Link list was successfully updated.'
  end

  test "handle url" do
    click_link 'Add Link List'
    fill_in 'Name', with: 'Some Uniq List'
    fill_in 'Handle', with: 'test-url'
    click_button 'Create Link list'
    assert page.has_content? 'Link list was successfully created.'
    assert current_path == "/admin/link_lists/test-url"
  end

  test "link_list has link" do
    click_link(@link_list.name, match: :first)
    assert page.has_content? @link.name
  end

  test 'add links to link_list' do
    click_link(@link_list.name, match: :first)
    click_link 'Add Links'
    fill_in 'Name', with: 'Uniq Link Name'
    fill_in 'Position', with: '1'
    fill_in 'Link type', with: 'search'
    click_button 'Create Link'
    assert page.has_content? 'Link was successfully created.'
    assert page.has_content? 'Editing Link'
  end

  test 'delete link from link_list' do
    click_link(@link_list.name, match: :first)
    click_link "Delete"
    assert page.has_no_content? @link.name
  end

  test "delete link_list" do
    assert page.has_content? @link_list.name
    click_link('Delete', match: :first)
    assert page.has_content? "No Link Lists"
  end
end
end
