# == Schema Information
#
# Table name: articles
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  content    :text
#  blog_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class Article < ActiveRecord::Base
  belongs_to :blog

  validates :title,
    presence: true,
    uniqueness: { scope: :blog_id }
end
