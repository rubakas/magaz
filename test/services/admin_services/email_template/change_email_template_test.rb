require 'test_helper'

class AdminServices::EmailTemplate::ChangeEmailTemplateTest < ActiveSupport::TestCase

  setup do
    @shop = create(:shop, name: 'shop_name')
    @email_template = create(:email_template, shop: @shop)
    @success_params = { title: "Changed title",
                        body: "Changed body"
                      }
    @partially_blank_params = { title: "Cnged title",
                                body: ""
                              }
end

  test 'should update email template with valid params' do
    service = AdminServices::EmailTemplate::ChangeEmailTemplate.new(id: @email_template.id,
                                                                    shop_id: @shop.id,
                                                                    params: @success_params)
                                                                .run
    assert service.success?
    assert_equal @success_params[:body], EmailTemplate
                                          .find(@email_template.id).body
    assert_equal @success_params[:title], EmailTemplate
                                          .find(@email_template.id).title
  end

  test 'should not update email template with blank_params' do
    service = AdminServices::EmailTemplate::ChangeEmailTemplate.new(id: @email_template.id,
                                                                    shop_id: @shop.id)
                                                                .run
    refute service.success?
    assert_equal 2, service.errors.full_messages.count
    assert_includes service.errors.full_messages, "Title can't be blank"
    assert_includes service.errors.full_messages, "Body can't be blank"
  end

  test "should rise exeption if shop/email_template not found" do
    assert_raises ActiveRecord::RecordNotFound do
      service = AdminServices::EmailTemplate::ChangeEmailTemplate.new.run
    end
  end
end
