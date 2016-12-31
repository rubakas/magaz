require 'test_helper'
class AdminServices::AssetFile::ChangeAssetFileTest < ActiveSupport::TestCase

  setup do
    @shop = create(:shop, name: "shop name")
    @file2 = fixture_file_upload('/files/tapir.jpg')
    @file = fixture_file_upload('/files/test.txt')
    @created_file = create(:file, shop: @shop, file: @file)
    @success_params = { 'file' => @file2, 'name' => 'New name' }
    @blank_params = { 'file' => nil, 'name' => '' }
  end

  test "should update file with valid params" do
    service = AdminServices::AssetFile::ChangeAssetFile
              .new( id:       @created_file.id,
                    shop_id:  @shop.id,
                    params:   @success_params)
              .run
    assert service.success?
    assert_equal "tapir.jpg", service.result.file.filename
  end

  test "should not update file with blank params" do
    service = AdminServices::AssetFile::ChangeAssetFile
              .new( id:       @created_file.id,
                    shop_id:  @shop.id,
                    params:   @blank_params)
              .run
    refute service.success?
    assert_equal 2, service.result.errors.count
    assert_equal "Name can't be blank", service.result.errors.full_messages.first
  end
end
