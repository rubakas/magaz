require 'test_helper'

class AdminServices::AssetFile::AddAssetFileTest < ActiveSupport::TestCase

  setup do
    @shop = create(:shop, name: "shop name")
    @file = fixture_file_upload('/files/test.txt')
    @success_params = { file: @file, name: 'New file' }
  end

  test "should add file with valid params" do
    assert_equal 0, AssetFile.count
    service = AdminServices::AssetFile::AddAssetFile
              .new(shop_id: @shop.id, params: @success_params)
              .run
    assert service.success?
    assert AssetFile.find(service.result.id)
    assert_equal 1, AssetFile.count
  end

  test "should not add file with blank name" do
    assert_equal 0, AssetFile.count
    invalid_params = @success_params.merge({ name: '' })
    service = AdminServices::AssetFile::AddAssetFile
              .new(shop_id: @shop.id, params: invalid_params)
              .run
    refute service.success?
    assert_equal 1, service.result.errors.count
    assert_equal "Name can't be blank", service.result.errors.full_messages.first
    assert_equal 0, AssetFile.count
  end


  test "should not add file with blank file" do
    assert_equal 0, AssetFile.count
    invalid_params = @success_params.merge({ file: '' })
    service = AdminServices::AssetFile::AddAssetFile
              .new(shop_id: @shop.id, params: invalid_params)
              .run
    refute service.success?
    assert_equal 1, service.result.errors.count
    assert_equal "File can't be blank", service.result.errors.full_messages.first
    assert_equal 0, AssetFile.count
  end
end
