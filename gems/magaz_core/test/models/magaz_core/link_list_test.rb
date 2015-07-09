require 'test_helper'

module MagazCore
  class LinkListTest < ActiveSupport::TestCase

    should belong_to(:shop)
    should have_many(:links).dependent(:destroy)
    should validate_presence_of(:name)
    should validate_uniqueness_of(:name).scoped_to(:shop_id)

  end
end
