class User < ActiveRecord::Base
  include Concerns::PasswordAuthenticable

  has_many    :events, as: :subject
  has_many    :reviews
  belongs_to  :shop

  def full_name
    [self.first_name, self.last_name].map(&:capitalize).join(" ")
  end
end
