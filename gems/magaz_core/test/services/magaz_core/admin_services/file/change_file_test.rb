require 'test_helper'
class MagazCore::AdminServices::File::ChangeFileTest < ActiveSupport::TestCase

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
    service = MagazCore::AdminServices::File::ChangeFile
                .run(id: @created_file.id,
                     file: @file2,
                     name: 'New name',
                     shop_id: @shop.id)
    assert service.valid?
    assert_equal "tapir.jpg", service.result.file.filename
  end

  test "should not update file with blank params" do
    service = MagazCore::AdminServices::File::ChangeFile
                .run(id: '',
                     file: '',
                     name: '',
                     shop_id: '')
    refute service.valid?
    assert_equal 3, service.errors.count
    assert_equal 'File is not a valid file', service.errors.full_messages.first
    assert_equal 'Id is not a valid integer', service.errors.full_messages[1]
    assert_equal 'Shop is not a valid integer', service.errors.full_messages.last
  end

end