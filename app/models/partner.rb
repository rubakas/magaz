class Partner < ApplicationRecord

  has_many :themes, dependent: :destroy
  
end
