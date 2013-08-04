require 'test_helper'

class Shop::PasswordAuthenticableTest < ActiveSupport::TestCase
  test 'validation email presence' do
    shop = Shop.new name:'New shop',
      password:'1234q'
    assert shop.invalid?
  end

  test 'validation email uniqueness' do
    uniq_shop = Shop.create name:'New shop 1', 
      email:'example@example.com', 
      password:'1234q'
    assert uniq_shop.valid?
    not_uniq_shop = Shop.create name:'New shop 2', 
      email:'example@example.com', 
      password:'1234q'
    assert not_uniq_shop.invalid?
  end

  test 'validation password presence' do
    shop = Shop.new name:'New shop', 
      email:'example4@example.com'
    assert shop.invalid?
  end

  test 'validation name presence' do
    shop = Shop.new email:'example4@example.com', 
      password:'1234q'
    assert shop.invalid?
  end

end
