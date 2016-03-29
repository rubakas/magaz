require 'test_helper'

module MagazCore
  class ShopServices::ChangeEmailTemplateTest < ActiveSupport::TestCase

    setup do
      @shop = create(:shop, name: 'shop_name')
      @email_template = create(:email_template, shop: @shop)
      @email_template2 = create(:email_template, shop: @shop, name: "New order Notification")
      @success_params = { id: @email_template.id, title: "Changed title", shop_id: @shop.id,
                          name: "Changed name", body: "Changed body", template_type: "new" }
      @blank_params = { id: nil, title: "", shop_id: nil, name: "", body: "", template_type: "" }    
    end

    test 'should update email template with valid params' do
      service = MagazCore::ShopServices::ChangeEmailTemplate.run(@success_params)
      assert service.valid?
      assert_equal "Changed name", MagazCore::EmailTemplate.find(@email_template.id).name
      assert_equal "Changed title",   MagazCore::EmailTemplate.find(@email_template.id).title
    end

    test 'should not update email template with blank_params' do
      service = MagazCore::ShopServices::ChangeEmailTemplate.run(@blank_params)
      refute service.valid?
      assert_equal 2, service.errors.full_messages.count
      assert_equal "Id is required", service.errors.full_messages.first
      assert_equal "Shop is required", service.errors.full_messages.last
    end

    test 'should not update email template with existing name' do
      service = MagazCore::ShopServices::ChangeEmailTemplate
              .run(id: @email_template.id, shop_id: @shop.id, name: @email_template2.name,
                   title: "Changed title", body: "Changed body", template_type: "new")
      refute service.valid?
      assert_equal 1, service.errors.full_messages.count
      assert_equal "Name has already been taken", service.errors.full_messages.first
    end

    test 'should update update email with some blank params' do
      service = MagazCore::ShopServices::ChangeEmailTemplate.
                  run(id: @email_template.id, title: "", shop_id: @email_template.id,
                          name: "Changed name", body: "", template_type: "" )
      assert service.valid?
      assert_equal '', service.result.body
      assert_equal '', service.result.title
    end
  end
end