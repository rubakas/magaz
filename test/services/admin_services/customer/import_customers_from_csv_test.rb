require 'test_helper'

class AdminServices::ImportCustomersFromCsvTest < ActiveSupport::TestCase
  setup do
    @shop = create(:shop)
  end

  test 'import customers' do
    file = ::File.expand_path("#{Rails.root}/test/fixtures/files/customers.csv", __FILE__)
    assert_difference "Customer.count", 2 do
      AdminServices::Customer::ImportCustomersFromCsv
      .new( shop_id: @shop.id, 
            csv_file: Rack::Test::UploadedFile.new(file, 'text/csv')).run
    end
  end

  test 'should have an exeption if shop not found' do
    assert_raise ActiveRecord::RecordNotFound do
      AdminServices::Customer::ImportCustomersFromCsv.new.run
    end
  end
end
