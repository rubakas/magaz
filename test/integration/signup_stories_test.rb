require 'test_helper'

class SignupStoriesTest < ActionDispatch::IntegrationTest
  setup do
    use_host HOSTNAME
    @default_theme = build(:theme)
    archive_path = ::File.expand_path("#{Rails.root}/test/fixtures/files/valid_theme.zip", __FILE__)
    ThemeServices::ImportFromArchive
      .call(archive_path: archive_path,
            theme: @default_theme,
            theme_attributes: { name: 'Default' })
  end

  test "signup success" do
    visit '/'
    assert page.has_content?('Welcome')

    fill_in 'Your shop name', with: 'Example2'
    fill_in 'Email address', with: 'uniq@example2.com'
    fill_in 'Password', with: 'password'
    fill_in 'User first name', with: 'User'
    fill_in 'User last name', with: 'Puzer'
    click_button 'Create your shop now'

    assert page.has_content?('Dashboard')
  end

  test "signup failure" do
    visit '/'
    assert page.has_content?('Welcome')

    fill_in 'Your shop name', with: ''
    fill_in 'Email address', with: ''
    fill_in 'Password', with: ''
    click_button 'Create your shop now'
    assert page.has_content?('Welcome')
    assert page.has_content?('5 errors')
  end

  test "signup failure: shope name already been taken" do
    visit '/'
    assert page.has_content?('Welcome')

    fill_in 'Your shop name', with: @shop.name
    fill_in 'Email address', with: 'uniq@example2.com'
    fill_in 'Password', with: 'password'
    fill_in 'User first name', with: 'User'
    fill_in 'User last name', with: 'Puzer'
    click_button 'Create your shop now'

    assert page.has_content?('Name has already been taken')
    assert page.has_content?('Welcome')
  end

  test "signup failure with just name" do
    visit '/'
    assert page.has_content?('Welcome')

    fill_in 'Your shop name', with: 'Example2'
    fill_in 'Email address', with: ''
    fill_in 'Password', with: ''
    click_button 'Create your shop now'
    assert page.has_content?('4 errors')
    assert page.has_content?('Welcome')
  end

end
