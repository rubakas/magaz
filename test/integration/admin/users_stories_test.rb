require 'test_helper'

module Admin
  class UserStoriesTest < ActionDispatch::IntegrationTest
    setup do
      login
      @user = create(:user, shop: @shop)

      click_link 'Settings'
      click_link 'Users'
    end

    test 'users list' do
      assert page.has_content? 'Users'
      assert page.has_content? @user.email
    end

    test 'create user' do
      click_link 'Add User'
      fill_in 'First name', with: 'Some Uniq Firt Name'
      fill_in 'Last name', with: 'Some Uniq Last Name'
      fill_in 'Email', with: 'examole@mail.com'
      fill_in 'Password', with: 'qwerty123'
      click_button 'Create User'
      assert page.has_content? 'User was successfully created.'
    end

    test 'edit user' do
      click_link(@user.email, match: :first)
      fill_in 'First name', with: 'Some Uniq Firt Name'
      fill_in 'Last name', with: 'Some Uniq Last Name'
      fill_in 'Email', with: 'examole@mail.com'
      fill_in 'Password', with: 'qwerty111'
      check('user_permissions_dashboard')
      assert find('#user_permissions_dashboard').checked?
      click_button 'Update User'
      assert page.has_content? 'User was successfully updated.'
    end

    test 'delete user' do
      assert page.has_content? 'Users'
      assert page.has_content? @user.email
      click_link('Delete', match: :first)
      assert page.has_content? "No Users"
    end
  end
end