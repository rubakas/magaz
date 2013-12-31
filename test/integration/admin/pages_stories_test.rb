require 'test_helper'

class Admin::PagesStoriesTest < ActionDispatch::IntegrationTest
  setup do
    login_as shop_name: 'Example',
      email: 'admin@example.com',
      password: 'password'
    click_link 'Pages'
  end

  test "pages list" do
    assert page.has_content? 'Pages'
  end

  test "create page" do
    click_link 'Add Page'
    fill_in 'Title', with: 'Some Uniq Page'
    fill_in 'Content', with: ''
    click_button 'Create Page'
    assert page.has_content? 'Page was successfully created'
  end

  test "create page failure" do
    click_link 'Add Page'
    fill_in 'Title', with: ''
    fill_in 'Content', with: ''
    click_button 'Create Page'
    assert page.has_content? '1 error prohibited this page from being saved'
  end

  test "edit page" do
    click_link(Page.first.title, match: :first)
    fill_in 'Title', with: 'Updated Page'
    fill_in 'Content', with: 'Updated Content'
    click_button 'Update Page'
    assert page.has_content? 'Page was successfully updated'
  end

  test "delete page" do
    assert page.has_content? 'Delete'
    click_link('Delete', match: :first)
    refute page.has_content? "You have no pages yet, let's create one!"
  end
end