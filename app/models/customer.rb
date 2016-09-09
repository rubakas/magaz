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

  has_many    :checkouts
  has_many    :events, as: :subject
  belongs_to  :shop

  validates :email, uniqueness: true, allow_blank: true
  validate :first_name_or_last_name_or_email

  def first_name_or_last_name_or_email
    if first_name.blank? && last_name.blank? && email.blank?
      errors[:base] << I18n.t('activerecord.errors.models.customer.email_or_name')
    end
  end

  def self.to_csv
    CSV.generate do |csv|
      csv << column_names
      all.each do |customer|
        csv << customer.attributes.values_at(*column_names)
      end
    end
  end

end
