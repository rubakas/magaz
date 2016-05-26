require 'test_helper'

class ThemeServices::CreateThemeStyleTest < ActiveSupport::TestCase

  setup do
    archive_path = ::File.expand_path("#{Rails.root}/test/fixtures/files/valid_theme.zip", __FILE__)
    @shop = create(:shop)
    @partner = create(:partner, name: "Author")
    @theme = Theme.new(name: "Test Theme", price: 70, industry: "Other", partner: @partner, shop: @shop)
    ThemeServices::ImportFromArchive.call archive_path: archive_path, theme: @theme
    @valid_params = {name: "New style", theme_id: @theme.id, image: "here can be image"}
  end

  test 'should create style with valid params' do
    service = ThemeServices::CreateThemeStyle.run(@valid_params)
    assert service.valid?
    assert ThemeStyle.find_by_id(service.result.id)
    assert_equal @valid_params[:name], service.result.name
    assert_equal @valid_params[:image], service.result.image
    assert_equal 1, @theme.theme_styles.count
  end

  test 'should not create style with same name in same theme' do
    service = ThemeServices::CreateThemeStyle.run(@valid_params)
    assert service.valid?
    duplicate_service = ThemeServices::CreateThemeStyle.run(@valid_params)
    refute duplicate_service.valid?
    assert_equal 1, @theme.theme_styles.count
    assert_equal 1, duplicate_service.theme_style.errors.full_messages.count
    assert_equal "Name has already been taken", duplicate_service.theme_style.errors.full_messages.last
  end

  test 'should create style with some blank image' do
    @valid_params[:image] = ''
    service = ThemeServices::CreateThemeStyle.run(@valid_params)
    assert service.valid?
    assert ThemeStyle.find_by_id(service.result.id)
    assert_equal @valid_params[:name], service.result.name
    assert_equal @valid_params[:image], service.result.image
    assert_equal 1, @theme.theme_styles.count
  end

  test 'should not create style with blank params' do
    service = ThemeServices::CreateThemeStyle.run(name: '', theme_id: '', image: '')
    refute service.valid?
    assert_equal 0, @theme.theme_styles.count
    assert_equal 1, service.theme_style.errors.full_messages.count
    assert_equal "Theme is not a valid integer", service.theme_style.errors.full_messages.last
  end

end
