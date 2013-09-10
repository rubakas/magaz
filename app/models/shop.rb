# == Schema Information
#
# Table name: shops
#
#  id                     :integer          not null, primary key
#  email                  :string(255)
#  name                   :string(255)
#  password_digest        :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  password_salt          :string(255)
#  password_reset_token   :string(255)
#  password_reset_sent_at :datetime
#  subdomain              :string(255)
#

class Shop < ActiveRecord::Base
  include PasswordAuthenticable
  include SubdomainOwner
  has_many :collections
  has_many :products
end
