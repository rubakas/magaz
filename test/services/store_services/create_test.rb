require 'test_helper'

class StoreServices::CreateTest < ActiveSupport::TestCase
  setup do
    @default_theme = build(:theme)
    archive_path = ::File.expand_path("#{Rails.root}/test/fixtures/files/valid_theme.zip", __FILE__)

    ThemeServices::ImportFromArchive
    .call(archive_path:     archive_path,
          theme:            @default_theme,
          theme_attributes: { name: 'Default' })

    @success_params = { shop_name: 'example42', first_name: 'First' ,
                        last_name: 'Last', email: 'email@mail.com',
                        password: 'password' }
  end

  test 'create shop with valid params' do
    service = StoreServices::Create.run(@success_params)

    assert service.valid?
    assert service.result[:user]
    assert service.result[:shop]

    refute service.result[:shop].themes.main.blank?
    assert_equal @default_theme, service.result[:shop].themes.main.first.source_theme
  end

  test 'fail shop creation when no default theme in system' do
    @default_theme.delete
    service = StoreServices::Create.run(@success_params)
    refute service.valid?
    assert_equal "No default theme in system", service.errors.full_messages.last
  end

  test 'fail shop creation when no user params' do
    service = StoreServices::Create.run( shop_name:   'example42',
                                         first_name:  '' ,
                                         last_name:   '',
                                         email:       '',
                                         password:    '')
    refute service.valid?
  end

  test 'fail shop creation when no shop params' do
    service = StoreServices::Create.run( shop_name:   '',
                                         first_name:  'First' ,
                                         last_name:   'Last',
                                         email:       'email@mail.com',
                                         password:    'password')
    refute service.valid?
  end

  test "shop and user should have association" do
    service = StoreServices::Create.run(@success_params)

    assert service.valid?
    assert service.result[:shop]
    refute service.result[:user].shop.blank?

    service.result[:shop].users.each do |user|
      assert user.shop_id == service.result[:shop].id
    end
  end

  test 'default content created' do
    service = StoreServices::Create.run(@success_params)
    assert service.valid?
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
