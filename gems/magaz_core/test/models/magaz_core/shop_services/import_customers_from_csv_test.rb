require 'test_helper'

module MagazCore
  class ShopServices::ImportCustomersFromCsvTest < ActiveSupport::TestCase
    setup do
      @shop = create(:shop)
    end

    test 'import customers' do

      csv_rows = <<-eos
id,first_name,last_name,email
30,FirstName1,LastName1,name1@example.com
20,FirstName2,LastName2,name2@example.com
eos

      file = Tempfile.new('new_customers.csv')
      file.write(csv_rows)
      file.rewind

      assert_difference "Customer.count", 2 do
        MagazCore::ShopServices::ImportCustomersFromCsv.call(shop_id: @shop.id, csv_file: Rack::Test::UploadedFile.new(file, 'text/csv'))
      end
    end

  end
end