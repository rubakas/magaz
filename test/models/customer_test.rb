class CustomerTest < ActiveSupport::TestCase
  # associations
  should have_many :checkouts
  should have_many :events
  should belong_to :shop
end
