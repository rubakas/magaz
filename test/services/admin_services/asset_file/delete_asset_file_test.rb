require 'test_helper'
class AdminServices::AssetFile::DeleteAssetFileTest < ActiveSupport::TestCase

 setup do
    @shop = create(:shop, name: "shop name")
    @file = fixture_file_upload('/files/tapir.jpg', 'image/jpg')
    @created_file = create(:file, shop: @shop, file: @file)
  end

  test "should delete file with valid params" do
    assert_equal 1, AssetFile.count
    service = AdminServices::AssetFile::DeleteAssetFile
              .new(id: @created_file.id, shop_id: @shop.id)
              .run
    assert service.success?
    assert_equal 0, AssetFile.count
  end
end
