require 'test_helper'

class Admin::BlogsStoriesTest < ActionDispatch::IntegrationTest
  setup do
    login
    visit '/admin/blogs'
  end

  test "blogs list" do
    assert page.has_content? 'Blogs'
  end

  test "create blog" do
    click_link 'Add Blog'
    fill_in 'Title', with: 'Some Uniq Blog Post'
    click_button 'Create Blog'
    assert page.has_content? 'Blog was successfully created'
  end

  test "create blog failure" do
    click_link 'Add Blog'
    fill_in 'Title', with: ''
    click_button 'Create Blog'
    assert page.has_content? '1 error prohibited this blog from being saved'
  end

  test "edit blog" do
    click_link(Blog.first.title, match: :first)
    fill_in 'Title', with: 'Updated Blog Post'
    click_button 'Update Blog'
    assert page.has_content? 'Blog was successfully updated'
  end

  test "delete blog" do
    assert page.has_content? 'Delete'
    click_link('Delete', match: :first)
    refute page.has_content? "You have no blogs yet, let's create one!"
  end
end