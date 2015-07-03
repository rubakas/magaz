require 'test_helper'

module MagazCore
  class LinkTest < ActiveSupport::TestCase

    should belong_to(:link_list)

  end
end
