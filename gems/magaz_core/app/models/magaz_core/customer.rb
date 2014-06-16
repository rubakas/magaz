module MagazCore
  class Customer < ActiveRecord::Base
    self.table_name = 'customers'
    has_many :checkouts
    belongs_to :shop

    # validates :email, presence: true

    def self.import(file)
      CSV.foreach(file.path, headers: true) do |row|
        customer = find_by_id(row["id"]) || new
        customer.attributes = row.to_hash
        customer.save
      end
    end
  end
end