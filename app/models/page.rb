# == Schema Information
#
# Table name: pages
#
#  id               :integer          not null, primary key
#  title            :string(255)
#  content          :string(255)
#  shop_id          :integer
#  created_at       :datetime
#  updated_at       :datetime
#  handle           :string(255)
#  page_title       :string(255)
#  meta_description :string(255)
#

class Page < ActiveRecord::Base
  belongs_to :shop

  validates :title,
    presence: true,
    uniqueness: { scope: :shop_id }
end
