require 'test_helper'

module MagazCore
  class ShopServices::ChangeEmailTemplateTest < ActiveSupport::TestCase

    setup do
      @shop = create(:shop, name: 'shop_name')
      @email_template = create(:email_template, shop: @shop)
      @success_params = {id: @email_template.id, title: "Changed title",
                         shop_id: @shop.id, body: "Changed body" }
      @blank_params = { id: nil, title: "", shop_id: nil, body: "", }    
    end

    test 'should update email template with valid params' do
      service = MagazCore::ShopServices::ChangeEmailTemplate.run(@success_params)
      assert service.valid?
      assert_equal @success_params[:body], MagazCore::EmailTemplate
                                            .find(@email_template.id).body
      assert_equal @success_params[:title], MagazCore::EmailTemplate
                                            .find(@email_template.id).title
    end

    test 'should not update email template with blank_params' do
      service = MagazCore::ShopServices::ChangeEmailTemplate.run(@blank_params)
      refute service.valid?
      assert_equal 2, service.errors.full_messages.count
      assert_equal "Id is required", service.errors.full_messages.first
      assert_equal "Shop is required", service.errors.full_messages.last
    end

    test 'should update update email with some blank params' do
      service = MagazCore::ShopServices::ChangeEmailTemplate
                                          .run(id: @email_template.id, body: "", title: "",
                                               shop_id: @email_template.id )
      assert service.valid?
      assert_equal '', service.result.body
      assert_equal '', service.result.title
    end
  end
end