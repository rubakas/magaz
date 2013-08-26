# == Schema Information
#
# Table name: products
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :text
#  created_at  :datetime
#  updated_at  :datetime
#  shop_id     :integer
#

class Product < ActiveRecord::Base
	belongs_to :shop

  validates :name, presence: true, uniqueness: { scope: :shop_id }
  validates :description, presence: true  
end
