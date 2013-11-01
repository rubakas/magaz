# == Schema Information
#
# Table name: products
#
#  id           :integer          not null, primary key
#  name         :string(255)
#  description  :text
#  created_at   :datetime
#  updated_at   :datetime
#  shop_id      :integer
#  product_type :string(255)
#  sku          :string(255)
#  price        :decimal(38, 2)
#

class Product < ActiveRecord::Base
  has_and_belongs_to_many :collections
	belongs_to :shop

  validates :name, presence: true, uniqueness: { scope: :shop_id }
  validates :description, presence: true
end
