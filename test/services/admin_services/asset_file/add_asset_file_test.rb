require 'test_helper'

class AdminServices::AssetFile::AddAssetFileTest < ActiveSupport::TestCase

  setup do
    @shop = create(:shop, name: "shop name")
    @file = fixture_file_upload('/files/test.txt')
  end

  test "should add file with valid params" do
    assert_equal 0, AssetFile.count
    service = AdminServices::AssetFile::AddAssetFile
              .run(file: @file, shop_id: @shop.id, name: 'New file')
    assert service.valid?
    assert AssetFile.find(service.result.id)
    assert_equal 1, AssetFile.count
  end

  test "should not add file with blank name" do
    assert_equal 0, AssetFile.count
    service = AdminServices::AssetFile::AddAssetFile
              .run(file: @file, shop_id: @shop.id, name: '')
    refute service.valid?
    assert_equal 1, service.datafile.errors.count
    assert_equal "Name can't be blank", service.datafile.errors.full_messages.first
    assert_equal 0, AssetFile.count
  end


  test "should not add file with blank file" do
    assert_equal 0, AssetFile.count
    service = AdminServices::AssetFile::AddAssetFile
              .run(file: '', shop_id: @shop.id, name: 'New file')
    refute service.valid?
    assert_equal 1, service.datafile.errors.count
    assert_equal 'File is not a valid file', service.datafile.errors.full_messages.first
    assert_equal 0, AssetFile.count
  end
end
