require 'test_helper'

class Admin::ArticlesStoriesTest < ActionDispatch::IntegrationTest
  setup do
    login
    save_and_open_page
    click_link 'Blog Posts'
  end

  test "blog posts list" do
    assert page.has_content? 'Blog Posts'
  end

  test "create blog post" do
    click_link 'Add Blog Post'
    fill_in 'Title', with: 'Some Uniq Blog Post'
    fill_in 'Content', with: ''
    click_button 'Create Article'
    assert page.has_content? 'Blog Post was successfully created'
  end

  test "create blog post failure" do
    click_link 'Add Blog Post'
    fill_in 'Title', with: ''
    fill_in 'Content', with: ''
    click_button 'Create Article'
    assert page.has_content? '1 error prohibited this article from being saved'
  end

  test "edit blog post" do
    click_link(Article.first.title, match: :first)
    fill_in 'Title', with: 'Updated Blog Post'
    fill_in 'Content', with: 'Updated Content'
    click_button 'Update Article'
    assert page.has_content? 'Blog Post was successfully updated'
  end

  test "delete blog post" do
    assert page.has_content? 'Delete'
    click_link('Delete', match: :first)
    refute page.has_content? "You have no blog posts yet, let's create one!"
  end
end