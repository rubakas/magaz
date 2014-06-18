module MagazCore
  class Customer < ActiveRecord::Base
    self.table_name = 'customers'
    has_many :checkouts
    belongs_to :shop

    # validates :email, presence: true

    def self.to_csv
      CSV.generate do |csv|
        csv << column_names
        all.each do |customer|
          csv << customer.attributes.values_at(*column_names)
        end
      end
    end

    def self.import(file)
      CSV.foreach(file.path, headers: true) do |row|
        customer = find_by_id(row["id"]) || new
        customer.attributes = row.to_hash
        customer.save
      end
    end
  end
end