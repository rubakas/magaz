class ThemeStyle < ApplicationRecord

  belongs_to :theme

  validates :name, uniqueness: { scope: :theme_id }

  module IndustryCategories
    INDUSTRIES_LIST = ["Art & Photography", "Clothing & Fashion",
                       "Electronics", "Food & Drink",
                       "Health & Beauty", "Home & Garden",
                       "Jewelry & Accessories", "Other",
                       "Responsive", "Sports & Recreation", "Toys & Games" ].freeze
  end

  scope :industry_category, -> (industry_name) do
      unless industry_name.blank?
        where(industry: industry_name) if IndustryCategories::INDUSTRIES_LIST.include?(industry_name)
      end 
    end

  scope :themes_price_category, -> (price_category_name) {joins(:theme).merge(Theme.price_category(price_category_name))}
  
  scope :get_industry_styles, -> (style) {self.where.not(id: style.id).where(industry: style.industry).limit(3)}

  scope :get_partner_styles, -> (partner) {joins(:theme).merge(Theme.where(partner_id: partner.id)).limit(3)}  
end
