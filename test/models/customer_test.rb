# == Schema Information
#
# Table name: customers
#
#  id                :integer          not null, primary key
#  accepts_marketing :boolean
#  email             :string
#  first_name        :string
#  last_name         :string
#  shop_id           :integer
#

require 'test_helper'

class CustomerTest < ActiveSupport::TestCase
  # associations
  should have_many :checkouts
  should belong_to :shop
end
