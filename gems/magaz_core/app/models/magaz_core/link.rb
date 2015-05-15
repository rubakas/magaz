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
    DEFAULT_HOME_LINK_NAME = I18n.t('activerecord.models.link.home_link_name')
    DEFAULT_BLOG_LINK_NAME = I18n.t('activerecord.models.link.blog_link_name')

    #Footer
    DEFAULT_SEARCH_LINK_NAME = I18n.t('activerecord.models.link.search_link_name')
    DEFAULT_ABOUT_LINK_NAME = I18n.t('activerecord.models.link.about_link_name')

    #TODO, dependent: :destroy?
    belongs_to :link_list

  end
end
