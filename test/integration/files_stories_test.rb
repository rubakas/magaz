require 'test_helper'

module Admin
  class AssetFilesStoriesTest < ActionDispatch::IntegrationTest
     setup do
      login
      @file = create(:file, shop: @shop)

      click_link 'Settings'
      click_link 'Files'
    end

    test 'files list' do
      assert page.has_content? 'Files'
      assert page.has_content? @file.name
    end

    test 'create file' do
      click_link 'Add File'
      fill_in 'Name', with: 'Some Uniq Product'
      attach_file('file_file', File.join(Rails.root, '/test/fixtures/asset_files/image.jpg'))
      click_button 'Create File'
      assert page.has_content? 'File was successfully created.'
    end

    test 'delete file' do
      assert page.has_content? 'Files'
      assert page.has_content? @file.name
      click_link('Delete', match: :first)
      assert page.has_content? "No Files"
    end
  end
end
