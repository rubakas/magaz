require 'test_helper'
class AdminServices::AssetFile::ChangeAssetFileTest < ActiveSupport::TestCase

  setup do
    @shop = create(:shop, name: "shop name")
    @file2 = fixture_file_upload('/files/tapir.jpg')
    @file = fixture_file_upload('/files/test.txt')
    @created_file = create(:file, shop: @shop, file: @file)
  end

  teardown do
    FileUtils.rm_rf(Dir["#{Rails.root}/public/uploads"])
  end

  test "should update file with valid params" do
    service = AdminServices::AssetFile::ChangeAssetFile
                .run(id: @created_file.id,
                     file: @file2,
                     name: 'New name',
                     shop_id: @shop.id)
    assert service.valid?
    assert_equal "tapir.jpg", service.result.file.filename
  end

  test "should not update file with blank params" do
    service = AdminServices::AssetFile::ChangeAssetFile
                .run(id: @created_file.id,
                     file: '',
                     name: '',
                     shop_id: @shop.id)
    refute service.valid?
    assert_equal 1, service.datafile.errors.count
    assert_equal 'File is not a valid file', service.datafile.errors.full_messages.first
  end

end
