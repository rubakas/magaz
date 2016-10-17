require "csv"

class AdminServices::Customer::ImportCustomersFromCsv
  attr_reader :success, :shop, :errors
  alias_method :success?, :success

  def initialize(shop_id: nil, csv_file: nil)
    @shop = Shop.find(shop_id)
    @csv_file = csv_file
  end

  def run
    if @csv_file.blank?
      return
    else
      _import_customers
      @success = true
    end
    self
  end

  private

  def _import_customers
    CSV.foreach(@csv_file.path, headers: true) do |row|
      customer = Customer.find_by_id(row["id"]) || Customer.new
      customer.attributes = row.to_hash
      customer.shop_id = @shop.id
      customer.save
    end
  end

end
