# == Schema Information
#
# Table name: pages
#
#  id               :integer          not null, primary key
#  title            :string
#  content          :string
#  shop_id          :integer
#  created_at       :datetime
#  updated_at       :datetime
#  handle           :string
#  page_title       :string
#  meta_description :string
#  slug             :string
#  publish_on       :datetime
#  published_at     :datetime
#

require 'test_helper'

class PageTest < ActiveSupport::TestCase
  include Shared::VisibilityExamples

  # associations
  should belong_to  :shop

  # validations
  should validate_presence_of(:shop_id)
  should validate_presence_of(:title)
  should validate_uniqueness_of(:title).scoped_to(:shop_id)

  setup do
    setup_visibility_examples(model_class: Page, factory_name: :page)
  end
end
