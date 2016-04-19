require 'test_helper'
class MagazCore::AdminServices::File::DeleteFileTest < ActiveSupport::TestCase

 setup do
    @shop = create(:shop, name: "shop name")
    @file = fixture_file_upload('/files/tapir.jpg', 'image/jpg')
    @created_file = create(:file, shop: @shop, file: @file)
  end

  teardown do
    FileUtils.rm_rf(Dir["#{Rails.root}/public/uploads"])
  end

  test "should delete file with valid params" do
    assert_equal 1, MagazCore::File.count
    service = MagazCore::AdminServices::File::DeleteFile
                .run(id: @created_file.id,
                     shop_id: @shop.id)
    assert service.valid?
    assert_equal 0, MagazCore::File.count
  end

  test "should not delete file with blank params" do
    assert_equal 1, MagazCore::File.count
    service = MagazCore::AdminServices::File::DeleteFile
                .run(id: '',
                     shop_id: '')
    assert_equal 1, MagazCore::File.count
    refute service.valid?
    assert_equal 2, service.errors.count
    assert_equal "Id is not a valid integer", service.errors.full_messages.first
    assert_equal "Shop is not a valid integer", service.errors.full_messages.last
    assert_equal 1, MagazCore::File.count
  end
end