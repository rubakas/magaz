# == Schema Information
#
# Table name: pages
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :string(255)
#  shop_id     :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class Page < ActiveRecord::Base
  belongs_to :shop

  validates :name,
    presence: true,
    uniqueness: { scope: :shop_id }
end
