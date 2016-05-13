require 'test_helper'

class AdminServices::File::AddFileTest < ActiveSupport::TestCase

  setup do
    @shop = create(:shop, name: "shop name")
    @file = fixture_file_upload('/files/test.txt')
  end

  teardown do
    FileUtils.rm_rf(Dir["#{Rails.root}/public/uploads"])
  end

  test "should add file with valid params" do
    assert_equal 0, File.count
    service = AdminServices::File::AddFile
                .run(file: @file, shop_id: @shop.id, name: 'New file')
    assert service.valid?
    assert File.find(service.result.id)
    assert_equal 1, File.count
  end

  test "should not add file with blank name" do
    assert_equal 0, File.count
    service = AdminServices::File::AddFile
                .run(file: @file, shop_id: @shop.id, name: '')
    refute service.valid?
    assert_equal 1, service.errors.count
    assert_equal "Name can't be blank", service.errors.full_messages.first
    assert_equal 0, File.count
  end


  test "should not add file with blank file" do
    assert_equal 0, File.count
    service = AdminServices::File::AddFile
                .run(file: '', shop_id: @shop.id, name: 'New file')
    refute service.valid?
    assert_equal 1, service.errors.count
    assert_equal 'File is not a valid file', service.errors.full_messages.first
    assert_equal 0, File.count
  end

  test "should not add file with blank shop_id" do
    assert_equal 0, File.count
    service = AdminServices::File::AddFile
                .run(file: @file, shop_id: '', name: 'New file')
    refute service.valid?
    assert_equal 1, service.errors.count
    assert_equal 'Shop is not a valid integer', service.errors.full_messages.first
    assert_equal 0, File.count
  end
end
