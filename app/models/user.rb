class User < ActiveRecord::Base
  include Concerns::PasswordAuthenticable
  
  self.table_name = 'users'

  has_many :events, as: :subject
  belongs_to :shop

  def full_name
    [self.first_name, self.last_name].map(&:capitalize).join(" ")
  end
end
