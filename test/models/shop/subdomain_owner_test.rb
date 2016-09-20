require 'test_helper'

class Shop::SubdomainOwnerTest < ActiveSupport::TestCase
  test 'assigns subdomain' do
    shop = create(:shop, name: 'uniq name')
    assert shop.valid?
    assert_equal shop.subdomain, 'uniq-name'
  end

  test 'subdomain format' do
    skip
  end

  test 'subdomain format - characters stripped' do
    skip
  end

  test 'subdomain uniqueness' do
    skip
  end

  test 'subdomain uniqueness - subdomain name is generated if needed' do
    skip
  end
end
