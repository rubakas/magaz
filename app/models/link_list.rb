# == Schema Information
#
# Table name: link_lists
#
#  id      :integer          not null, primary key
#  name    :string
#  shop_id :integer
#  handle  :string
#  slug    :string
#


class LinkList < ActiveRecord::Base
  extend FriendlyId

  has_many   :links, dependent: :destroy
  belongs_to :shop

  accepts_nested_attributes_for :links
  friendly_id :handle, use: [:slugged, :scoped], scope: :shop

  validates :name, :shop_id, presence: true
  validates :name, uniqueness: { scope: :shop_id }

  def should_generate_new_friendly_id?
    handle_changed?
  end

end
