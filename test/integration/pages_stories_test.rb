require 'test_helper'

class PagesStoriesTest < ActionDispatch::IntegrationTest
  setup do
    login
    @page = create(:page, shop: @shop)
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
    fill_in 'Content', with: ''
    click_button 'Create Page'
    save_and_open_screenshot
    assert page.has_content? '1 error prohibited this page from being saved'
  end

  test "handle url" do
    click_link 'Add Page'
    fill_in 'Title', with: 'Some Uniq Page'
    fill_in 'Content', with: 'Some Uniq Content'
    fill_in 'Handle', with: 'test-url'
    click_button 'Create Page'
    assert page.has_content? 'Page was successfully created.'
    assert current_path == "/admin/pages/test-url"
  end

  test "handle url update" do
    click_link 'Add Page'
    fill_in 'Title', with: 'Some Uniq Page'
    fill_in 'Content', with: 'Some Uniq Content'
    fill_in 'Handle', with: 'test-url'
    click_button 'Create Page'
    assert page.has_content? 'Page was successfully created.'
    assert current_path == "/admin/pages/test-url"
    fill_in 'Handle', with: 'edit-test-url'
    click_button 'Update Page'
    assert page.has_content? 'Page was successfully updated.'
    assert current_path == "/admin/pages/edit-test-url"
  end

  test "edit page" do
    click_link(@page.title, match: :first)
    fill_in 'Title', with: 'Updated Page'
    fill_in 'Content', with: 'Updated Content'
    click_button 'Update Page'
    assert page.has_content? 'Page was successfully updated'
  end

  test "delete page" do
    assert page.has_content? 'Delete'
    click_link('Delete', match: :first)
    assert page.has_content? "You have no pages yet, let's create one!"
  end
end