class CustomerTest < ActiveSupport::TestCase
  should have_many :checkouts
  should have_many :events
  should belong_to :shop
end
