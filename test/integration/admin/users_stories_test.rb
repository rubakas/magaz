require 'test_helper'

module Admin
  class UserStoriesTest < ActionDispatch::IntegrationTest
    setup do
      login
      @user2 = create(:user, shop: @shop, account_owner: true)

      click_link 'Settings'
      click_link 'Users'
    end

    test 'users list' do
      assert page.has_content? 'Users'
      assert page.has_content? @user.email
      assert page.has_content? @user2.email
    end

    test 'invite user' do
      click_link 'Invite User'
      fill_in 'Email', with: 'user@email.com'
      click_button 'Create User'
      assert page.has_content? 'User was successfully created.'
    end

    test 'edit user' do
      click_link(@user2.email, match: :first)
      fill_in 'First name', with: 'Some Uniq Firt Name'
      fill_in 'Last name', with: 'Some Uniq Last Name'
      fill_in 'Email', with: 'examole@mail.com'
      fill_in 'Password', with: 'qwerty111'
      check('user_permissions_dashboard')
      assert find('#user_permissions_dashboard').checked?
      click_button 'Update User'
      assert page.has_content? 'User was successfully updated.'
    end

    test 'should delete user' do
      assert page.has_content? 'Users'
      click_link('Delete', match: :first)
      assert page.has_content? "User was successfully deleted."
    end

    test "should not delete user" do
      assert page.has_content? 'Users'
      click_link('Delete', href: "/admin/users/#{@user2.id}")
      assert page.has_content? "Can't delete shop owner."
    end
  end
end