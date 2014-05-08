module MagazCore
  class Customer < ActiveRecord::Base
    self.table_name = 'customers'
    has_many :checkouts
    belongs_to :shop

    # validates :email, presence: true
  end
end