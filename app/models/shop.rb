# == Schema Information
#
# Table name: shops
#
#  id              :integer          not null, primary key
#  email           :string(255)
#  name            :string(255)
#  password_digest :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#  password_salt   :string(255)
#  subdomain       :string(255)
#

class Shop < ActiveRecord::Base
  include PasswordAuthenticable
  include SubdomainOwner
  has_many :collections
  has_many :products
  has_many :pages
  has_many :blogs
  has_many :orders
  has_many :product_images
end
