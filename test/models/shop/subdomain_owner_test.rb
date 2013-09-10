require 'test_helper'

class Shop::SubdomainOwnerTest < ActiveSupport::TestCase
  test 'assigns subdomain' do
    shop = Shop.new(name: 'uniq name', email: 'email@uniq-name.com', password: 'password')
    assert shop.valid?
    assert_equal shop.subdomain, 'uniq-name'
  end
end