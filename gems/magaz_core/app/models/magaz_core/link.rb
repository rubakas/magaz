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

    #TODO, dependent: :destroy?
    belongs_to :link_list

  end
end
