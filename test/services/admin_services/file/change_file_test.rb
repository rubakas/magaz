require 'test_helper'
class AdminServices::File::ChangeFileTest < ActiveSupport::TestCase

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
    service = AdminServices::File::ChangeFile
                .run(id: @created_file.id,
                     file: @file2,
                     name: 'New name',
                     shop_id: @shop.id)
    assert service.valid?
    assert_equal "tapir.jpg", service.result.file.filename
  end

  test "should not update file with blank params" do
    service = AdminServices::File::ChangeFile
                .run(id: '',
                     file: '',
                     name: '',
                     shop_id: @shop.id)
    refute service.valid?
    assert_equal 2, service.errors.count
    assert_equal 'File is not a valid file', service.errors.full_messages.first
    assert_equal 'Id is not a valid integer', service.errors.full_messages.last
  end

end
