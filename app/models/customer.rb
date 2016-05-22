# == Schema Information
#
# Table name: customers
#
#  id                :integer          not null, primary key
#  accepts_marketing :boolean
#  email             :string
#  first_name        :string
#  last_name         :string
#  shop_id           :integer
#


class Customer < ActiveRecord::Base
  self.table_name = 'customers'

  has_many    :checkouts
  has_many    :events, as: :subject
  belongs_to  :shop

  def self.to_csv
    CSV.generate do |csv|
      csv << column_names
      all.each do |customer|
        csv << customer.attributes.values_at(*column_names)
      end
    end
  end

end
