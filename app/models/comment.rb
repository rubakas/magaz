# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  author     :string(255)
#  body       :text
#  email      :string(255)
#  blog_id    :integer
#  created_at :datetime
#  updated_at :datetime
#  article_id :integer
#

class Comment < ActiveRecord::Base
  belongs_to :blog
  belongs_to :article

  validates :author, presence: true, uniqueness: { scope: :article_id }
  validates :email, presence: true
  validates :body, presence: true
end
