require 'test_helper'

class ThemeServices::CreatePartnerTest < ActiveSupport::TestCase

  setup do
    @valid_params = {name: "Author", website_url: "http://www.mysite.com"}
  end

  test 'should create partner with valid params' do
    service = ThemeServices::CreatePartner.run(@valid_params)
    assert service.valid?
    assert Partner.find_by_id(service.result.id)
    assert_equal @valid_params[:name], service.result.name
    assert_equal @valid_params[:website_url], service.result.website_url
    assert_equal 1, Partner.count
  end

  test 'should not create partner with invalid website_url' do
    @valid_params[:website_url] = "mywebsitecom" 
    service = ThemeServices::CreatePartner.run(@valid_params)
    refute service.valid?
    assert_equal 0, Partner.count
    assert_equal 1, service.partner.errors.full_messages.count
    assert_equal "Website url is invalid", service.partner.errors.full_messages.last
  end

  test 'should not create partner with same params' do
    service = ThemeServices::CreatePartner.run(@valid_params)
    assert service.valid?
    duplicate = ThemeServices::CreatePartner.run(@valid_params)
    refute duplicate.valid?
    assert_equal 1, Partner.count
    assert_equal 2, duplicate.partner.errors.full_messages.count
    assert_equal "Name has already been taken", duplicate.partner.errors.full_messages.first
    assert_equal "Website has already been taken", duplicate.partner.errors.full_messages.last
  end

  test 'should not create partner with blank params' do
    service = ThemeServices::CreatePartner.run(name: '', website_url: '')
    refute service.valid?
    assert_equal 3, service.partner.errors.full_messages.count
    assert_equal "Name can't be blank", service.partner.errors.full_messages.first
    assert_equal "Website url is invalid", service.partner.errors.full_messages.last
    assert_equal 0, Partner.count
  end


end
