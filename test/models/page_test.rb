require 'test_helper'

class PageTest < ActiveSupport::TestCase
  include Shared::VisibilityExamples

  should have_many  :events
  should belong_to  :shop
  should validate_presence_of(:shop_id)
  should validate_presence_of(:title)
  should validate_uniqueness_of(:title).scoped_to(:shop_id)

  setup do
    setup_visibility_examples(model_class: Page, factory_name: :page)
  end
end
