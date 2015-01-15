module MagazCore
  class Country < ActiveRecord::Base
    self.table_name = 'countries'

    belongs_to :shop

    validates :code, :name, presence: true
    validates :code, :name, uniqueness: true
  end
end