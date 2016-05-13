require 'test_helper'

module MagazCore
  class EmailTemplateTest < ActiveSupport::TestCase

    setup do
      @shop = create(:shop)
      @email_template = create(:email_template, shop: @shop)
    end

    test "should have default values after create" do
      assert_not @email_template.name.blank?
      assert_not @email_template.body.blank?
      assert_not @email_template.title.blank?
      assert_not @email_template.template_type.blank?
    end
  end
end
