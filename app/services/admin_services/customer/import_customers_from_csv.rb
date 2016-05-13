require "csv"

class AdminServices::Customer::ImportCustomersFromCsv
  include Concerns::Service

  def call(shop_id:, csv_file:)
    Shop.find(shop_id)
    if csv_file.blank?
      return
    else
      _import_customers(csv_file, shop_id)
    end
  end

  private

  def _import_customers(csv_file, shop_id)
    CSV.foreach(csv_file.path, headers: true) do |row|
      customer = Customer.find_by_id(row["id"]) || Customer.new
      customer.attributes = row.to_hash
      customer.shop_id = shop_id
      customer.save
    end
  end

end
