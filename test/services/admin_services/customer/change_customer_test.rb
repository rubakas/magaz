require 'test_helper'

class AdminServices::Customer::ChangeCustomerTest < ActiveSupport::TestCase

  setup do
    @shop = create(:shop, name: 'shop_name')
    @customer = create(:customer, shop: @shop)
    @customer2 = create(:customer, shop: @shop)
    @success_params = {
      'first_name'  => "Changed first name",
      'last_name'   => "CHanged last name",
      'email'       => "Changedtest@test.com"
    }
    @not_uniq_params = {
      'first_name' => "Changed first name",
      'last_name'  => "CHanged last name",
      'email'      => @customer2.email
     }
  end

  test 'should update customer with valid params' do
    service = AdminServices::Customer::ChangeCustomer
              .new( id:       @customer.id,
                    shop_id:  @shop.id,
                    params:   @success_params)
              .run
    assert service.success?
    assert_equal "Changedtest@test.com", Customer.find(@customer.id).email
    assert_equal 'Changed first name', Customer.find(@customer.id).first_name
  end

  test 'should not update customer with blank_params' do
    service = AdminServices::Customer::ChangeCustomer.new(id: @customer.id,
                                                          shop_id: @shop.id)
                                                     .run
    refute service.success?
    assert_includes service.customer.errors.full_messages, "At least one of these fields must be filled: First name, Last name, Email"
    assert_equal 1, service.errors.full_messages.count
  end

  test 'should not update customer with existing email' do
    service = AdminServices::Customer::ChangeCustomer
              .new(id:      @customer.id,
                   shop_id: @shop.id,
                   params:  @not_uniq_params)
              .run
    refute service.success?
    assert_equal 1, service.errors.full_messages.count
    assert_includes service.customer.errors.full_messages, "Email has already been taken"
  end

  test 'should update customer with some blank params' do
    service = AdminServices::Customer::ChangeCustomer
              .new( id:       @customer.id,
                    shop_id:  @shop.id,
                    params: { 'first_name' => "Changed first name",
                              'last_name' => '',
                              'email'     => @customer.email } )
              .run
    assert service.success?
    assert_equal '', service.customer.last_name
  end

  test "should rise exeption if shop/customer not found" do
    assert_raises ActiveRecord::RecordNotFound do
      service = AdminServices::Customer::ChangeCustomer.new(shop_id: "").run
    end
  end
end
