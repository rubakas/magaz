require 'test_helper'

class StoreServices::CreateTest < ActiveSupport::TestCase
  setup do
    @default_theme = build(:theme)
    archive_path = ::File.expand_path("#{Rails.root}/test/fixtures/files/valid_theme.zip", __FILE__)

    ThemeServices::ImportFromArchive
    .new(archive_path:     archive_path,
          theme:            @default_theme,
          theme_attributes: { name: 'Default' })
    .run

    @success_params = { name: 'example42', first_name: 'First' ,
                        last_name: 'Last', email: 'email@mail.com',
                        password: 'password' }
    @blank_params =   { name: 'example42', first_name: '',
                        last_name: '', email: '',
                        password: '' }
  end

  test 'create shop with valid params' do
    service = StoreServices::Create
              .new(params: @success_params)
              .run
    assert service.success?
    assert service.result[:user]
    assert service.result[:shop]

    refute service.result[:shop].themes.main.blank?
    assert_equal @default_theme, service.result[:shop].themes.main.first.source_theme
  end

  #score: 1
  test 'fail shop creation when no default theme in system' do
    @default_theme.destroy
    service = StoreServices::Create
              .new(params: @success_params)
              .run
    refute service.success?
    assert_includes service.errors, "No default theme in system"
  end

  test 'fail shop creation when no user params' do
    service = StoreServices::Create
              .new(params: @blank_params)
              .run
    refute service.success?
  end

  test 'fail shop creation when no shop params' do
    invalid_params = @success_params.merge({name: ''})
    service = StoreServices::Create
              .new(params: invalid_params)
              .run
    refute service.success?
  end

  test "shop and user should have association" do
    service = StoreServices::Create
              .new(params: @success_params)
              .run

    assert service.success?
    assert service.result[:shop]
    refute service.result[:user].shop.blank?

    service.result[:shop].users.each do |user|
      assert user.shop_id == service.result[:shop].id
    end
  end

  test 'default content created' do
    service = StoreServices::Create
              .new(params: @success_params)
              .run

    assert service.success?
    assert service.result[:shop]

    assert_equal 11,  service.result[:shop].email_templates.length
    assert_equal 1,   service.result[:shop].collections.length
    assert_equal 1,   service.result[:shop].blogs.length
    assert_equal 1,   service.result[:shop].articles.length
    assert_equal 2,   service.result[:shop].pages.length
    assert_equal 2,   service.result[:shop].link_lists.length
    assert_equal 4,   service.result[:shop].links.length
  end

end
