require 'test_helper'

module MagazCore
  class TaxOverrideTest < ActiveSupport::TestCase

    should belong_to(:collection)
    should belong_to(:shipping_country)
    should validate_presence_of(:shipping_country_id)
    should validate_presence_of(:rate)
    should validate_numericality_of(:rate)

  end
end
