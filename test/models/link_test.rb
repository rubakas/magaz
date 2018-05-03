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

require 'test_helper'

class LinkTest < ActiveSupport::TestCase
  # associations
  should belong_to :link_list

  # validations
  should validate_presence_of(:name)
  should validate_presence_of(:link_list_id)
  should validate_uniqueness_of(:name).scoped_to(:link_list_id)
end
