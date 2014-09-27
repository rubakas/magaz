require 'test_helper'

module MagazCore
  class ShopServices::ImportCustomersFromCsvTest < ActiveSupport::TestCase
    setup do
      @shop = create(:shop)
    end

    test 'import customers' do
      file = ::File.expand_path('./../../../../fixtures/files/customers.csv', __FILE__)
      assert_difference "Customer.count", 2 do
        MagazCore::ShopServices::ImportCustomersFromCsv.call(shop_id: @shop.id, csv_file: Rack::Test::UploadedFile.new(file, 'text/csv'))
      end
    end

  end
end