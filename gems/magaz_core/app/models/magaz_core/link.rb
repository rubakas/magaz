# == Schema Information
#
# Table name: links
#
#  id             :integer          not null, primary key
#  name           :string
#  link_type      :string
#  position       :integer
#  subject        :string
#  subject_params :string
#  subject_id     :integer
#  link_list_id   :integer
#

module MagazCore
  class Link < ActiveRecord::Base
    self.table_name = 'links'

    #Main Menu
    DEFAULT_HOME_LINK_NAME = "Home"
    DEFAULT_BLOG_LINK_NAME = "Blog"

    #Footer
    DEFAULT_SEARCH_LINK_NAME = "Search"
    DEFAULT_ABOUT_LINK_NAME = "About Us"

    #TODO, dependent: :destroy?
    belongs_to :link_list

  end
end
