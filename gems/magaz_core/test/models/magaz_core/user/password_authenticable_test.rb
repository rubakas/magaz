require 'test_helper'

module MagazCore
  class User::PasswordAuthenticableTest < ActiveSupport::TestCase
    test 'authentic_password?' do
      @shop = create(:shop)
      @user = create(:user, shop: @shop)
      assert @user.authentic_password?('password')
      refute @user.authentic_password?('wrong password')
      refute @user.authentic_password?('')
    end

    test 'validation email presence' do
      user = User.new first_name: 'New User',
                      last_name: 'Last',
                      password: '1234q'
      assert user.invalid?
    end

    test 'validation email uniqueness' do
      uniq_user = User.create first_name: 'New user',
                              last_name: 'number One',
                              email: 'example@example.com',
                              password: '1234q'
      assert uniq_user.valid?
      not_uniq_user = User.create first_name: 'New user',
                                  last_name: 'number Two',
                                  email: 'example@example.com',
                                  password: '1234q'
      assert not_uniq_user.invalid?
    end

    test 'validation password presence' do
      user = User.new first_name: 'New user',
                      last_name: 'number One',
                      email: 'example@example.com'
      assert user.invalid?
    end

    test 'validation first name presence' do
      user = User.new last_name: 'number One',
                      email: 'example@example.com',
                      password: '1234q'
      assert user.invalid?
    end

    test 'validation last name presence' do
      user = User.new first_name: 'New user',
                      email: 'example@example.com',
                      password: '1234q'
      assert user.invalid?
    end

  end
end