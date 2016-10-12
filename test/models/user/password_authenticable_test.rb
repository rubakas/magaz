require 'test_helper'

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
    assert user.invalid?(:invite)
  end

  test 'validation email uniqueness' do
    @shop = create(:shop)
    uniq_user = User.create first_name: 'New user',
                            last_name: 'number One',
                            email: 'example@example.com',
                            password: '1234q',
                            shop_id: @shop.id
    assert uniq_user.valid?(:create_shop)
    assert uniq_user.valid?(:invite)
    not_uniq_user = User.create first_name: 'New user',
                                last_name: 'number Two',
                                email: 'example@example.com',
                                password: '1234q',
                                shop_id: @shop.id
    assert not_uniq_user.invalid?(:invite)
  end

  test 'validation password presence' do
    user = User.new first_name: 'New user',
                    last_name: 'number One',
                    email: 'example@example.com'
    assert user.invalid?(:create_shop)
  end

end
