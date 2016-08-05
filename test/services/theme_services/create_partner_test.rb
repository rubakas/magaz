require 'test_helper'

class ThemeServices::CreatePartnerTest < ActiveSupport::TestCase

  setup do
    @valid_params = { name: "Author", website_url: "http://www.mysite.com" }
    @blank_params = { name: '', website_url: '' }
  end

  test 'should create partner with valid params' do
    service = ThemeServices::CreatePartner
              .new(params: @valid_params)
              .run
    assert service.success?
    assert Partner.find_by_id(service.result.id)
    assert_equal @valid_params[:name], service.result.name
    assert_equal @valid_params[:website_url], service.result.website_url
    assert_equal 1, Partner.count
  end

  test 'should not create partner with invalid website_url' do
    invalid_params = @valid_params.merge({ website_url: "mywebsitecom" })
    service = ThemeServices::CreatePartner
              .new(params: invalid_params)
              .run
    refute service.success?
    assert_equal 0, Partner.count
    assert_equal 1, service.result.errors.full_messages.count
    assert_equal "Website url is invalid", service.result.errors.full_messages.last
  end

  test 'should not create partner with same params' do
    service = ThemeServices::CreatePartner
              .new(params: @valid_params)
              .run
    assert service.success?
    duplicate = ThemeServices::CreatePartner
              .new(params: @valid_params)
              .run
    refute duplicate.success?
    assert_equal 1, Partner.count
    assert_equal 2, duplicate.result.errors.full_messages.count
    assert_equal "Name has already been taken", duplicate.result.errors.full_messages.first
    assert_equal "Website url has already been taken", duplicate.result.errors.full_messages.last
  end

  test 'should not create partner with blank params' do
    service = ThemeServices::CreatePartner
              .new(params: @blank_params)
              .run
    refute service.success?
    assert_equal 3, service.result.errors.full_messages.count
    assert_equal "Name can't be blank", service.result.errors.full_messages.first
    assert_equal "Website url is invalid", service.result.errors.full_messages.last
    assert_equal 0, Partner.count
  end

end
