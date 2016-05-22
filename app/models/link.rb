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


class Link < ActiveRecord::Base

  belongs_to :link_list

end
