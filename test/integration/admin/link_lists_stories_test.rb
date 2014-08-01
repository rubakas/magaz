require 'test_helper'

class Admin::LinkListsStoriesTest < ActionDispatch::IntegrationTest
  setup do
    login
    @link_list = create(:link_list, shop: @shop)
    @link = create(:link, link_list_id: @link_list)
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

  test "delete link_list" do
      assert page.has_content? @link_list.name
      click_link('Delete', match: :first)
      assert page.has_content? "No Link Lists"
  end
end