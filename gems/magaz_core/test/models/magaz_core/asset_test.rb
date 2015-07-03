# == Schema Information
#
# Table name: assets
#
#  id           :integer          not null, primary key
#  theme_id     :integer
#  content_type :string
#  key          :string
#  public_url   :string
#  size         :integer
#  src          :string
#  value        :string
#  created_at   :datetime
#  updated_at   :datetime
#

require 'test_helper'

module MagazCore
  class AssetTest < ActiveSupport::TestCase
    should belong_to(:theme)
  end
end
