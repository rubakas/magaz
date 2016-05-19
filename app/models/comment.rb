# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  author     :string
#  body       :text
#  email      :string
#  blog_id    :integer
#  created_at :datetime
#  updated_at :datetime
#  article_id :integer
#


class Comment < ActiveRecord::Base
  self.table_name = 'comments'

  belongs_to :article
  belongs_to :blog
  has_many :events, as: :subject

end
