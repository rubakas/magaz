require 'test_helper'

class AdminServices::Collection::ChangeCollectionTest < ActiveSupport::TestCase

  setup do
    @shop = create(:shop, name: 'shop_name')
    @collection = create(:collection, shop: @shop)
    @collection2 = create(:collection, shop: @shop)

    @success_params = {
      'name'              => "Changed name",
      'page_title'        =>  "Changed page_title",
      'handle'            => "Changed handle",
      'meta_description'  => "Changed meta_description",
      'description'       => "Test description"
    }

    @blank_params = {
      'name'              => 'New name',
      'page_title'        => '',
      'handle'            => '',
      'meta_description'  => '',
      'description'       => ''
    }
  end

  test 'should update collection with valid params' do
    service = AdminServices::Collection::ChangeCollection
              .new( shop_id:  @shop.id,
                    id:       @collection.id,
                    params:   @success_params)
              .run
    assert service.success?
    assert service.result
    assert_equal "Changed page_title",  Collection.find(@collection.id).page_title
    assert_equal 'Changed name',        Collection.find(@collection.id).name
    assert_equal "Changed handle",      Collection.find(@collection.id).handle
  end

  test 'should not update collection with existing name' do
    invalid_params = @success_params.merge({ 'name' => @collection2.name })

    service = AdminServices::Collection::ChangeCollection
              .new( shop_id:  @shop.id,
                    id:       @collection.id,
                    params:   invalid_params)
              .run
    refute service.success?
    assert_equal 1, service.result.errors.count
    assert_equal "Name has already been taken", service.result.errors.full_messages.first
  end

  test 'should update collection with some blank params' do
    service = AdminServices::Collection::ChangeCollection
              .new( shop_id:  @shop.id,
                    id:       @collection.id,
                    params:   @blank_params)
              .run
    assert service.success?
    assert_equal '', service.result.handle
    assert_equal '', service.result.page_title
  end
end
