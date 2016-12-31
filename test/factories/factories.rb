FactoryGirl.define do
  factory :article, class: Article do
    sequence(:title)   { |n| "Article #{n}" }
    sequence(:content) { |n| "Article #{n} content" }
    blog
  end

  factory :asset, class: Asset do
  end

  factory :blog, class: Blog do
    sequence(:title) { |n| "Blog #{n}" }
    shop
  end

  factory :collection, class: Collection do
    sequence(:name)        { |n| "Collection #{n}" }
    sequence(:description) { |n| "Collection #{n} description" }
  end

  factory :comment, class: Comment do
    sequence(:author) { |n| "author of comment #{n}" }
    sequence(:body)   { |n| "Comment #{n}" }
    sequence(:email)  { |n| "commenter#{n}@gmail.com" }
  end

  factory :checkout, class: Checkout do
  end

  factory :customer, class: Customer do
    sequence(:first_name) { |n| "First Name #{n} "}
    sequence(:last_name)  { |n| "Last Name #{n}"}
    sequence(:email)      { |n| "customer#{n}@gmail.com" }
  end

  factory :email_template, class: EmailTemplate do
    sequence(:name)           { |n| "Order Notification"}
    sequence(:title)          { |n| "New order"}
    sequence(:body)           { |n| "You have a new order"}
    sequence(:template_type)  { |n| "new_order_notification"}
    sequence(:description)    { |n| "some description"}
  end

  factory :file, class: AssetFile do
    sequence(:name) { |n| "File #{n}" }
    file            { Rack::Test::UploadedFile.new(File.join(Rails.root, '/test/fixtures/files/image.jpg')) }
  end

  factory :link_list, class: LinkList do
    sequence(:name)  { |n| "List #{n}" }
  end

  factory :link, class: Link do
    sequence(:name)   { |n| "Link #{n}" }
  end

  factory :partner, class: Partner do
    sequence(:name)         { |n| "Name#{n}" }
    sequence(:website_url)  { |n| "https://site#{n}.com" }
  end

  factory :page, class: Page do
    sequence(:title)   { |n| "Title #{n}" }
    sequence(:content) { |n| "Content #{n}" }
    shop
  end

  factory :product, class: Product do
    sequence(:name)        { |n| "Example #{n}" }
    sequence(:description) { |n| "Example #{n} description" }
    price { [0.99, 1.01].sample }
  end

  factory :product_image, class: ProductImage do
  end

  factory :shipping_country, class: ShippingCountry do
    sequence(:name) { |n| "UA" }
    sequence(:tax)  { |n| "#{n}" }
  end

  factory :shipping_rate, class: ShippingRate do
    sequence(:name)   { |n| "Shipping Rate #{n}" }
    sequence(:shipping_price) { 123 }
    criteria "test"
  end

  factory :shop, class: Shop do
    sequence(:name)                     { |n| "Example#{n}" }
    sequence(:subdomain)                { |n| "example#{n}" }
    all_taxes_are_included              true
    charge_taxes_on_shipping_rates      false
    account_type_choice                 ::Shop::ACCOUNT_TYPE_CHOISE[::Shop::ACCOUNT_TYPE_CHOISE.index('disabled')]
    enable_multipass_login              false
    billing_address_is_shipping_too     false
    abandoned_checkout_time_delay       ::Shop::ABANDONED_CHECKOUT_TIME_DELAY[::Shop::ABANDONED_CHECKOUT_TIME_DELAY.index('never')]
    email_marketing_choice              ::Shop::EMAIL_MARKETING_CHOICE[::Shop::EMAIL_MARKETING_CHOICE.index('customer_agrees')]
    after_order_paid                    ::Shop::AFTER_ORDER_PAID[::Shop::AFTER_ORDER_PAID.index('automatically_fulfill')]
    notify_customers_of_their_shipment  false
    automatically_fulfill_all_orders    false
    after_order_fulfilled_and_paid      false
    checkout_refund_policy              nil
    checkout_privacy_policy             nil
    checkout_term_of_service            nil
    business_name                       'business_name'
    city                                'city'
    country                             'US'
    currency                            'USD'
    customer_email                      'some@email.com'
    phone                               'phone'
    timezone                            'American Samoa'
    unit_system                         'metric'
    zip                                 'zip'
    page_title                          'page_title'
    meta_description                    'meta_description'
    address                             'address'
  end

  factory :subscriber_notification, class: SubscriberNotification do
    sequence(:notification_method)  { |n| "email #{n}" }
    sequence(:subscription_address) { |n| "some1#{n}@here.run" }
  end

  factory :tax_override, class: TaxOverride do
    sequence(:rate)         { |n| "#{n}"}
    sequence(:is_shipping)  { |n| false }
  end

  factory :theme, class: Theme do
    sequence(:name)      { |n| "Theme#{n}" }
  end

  factory :theme_style, class: ThemeStyle do
    sequence(:name)     { |n| "Theme#{n}" }
    sequence(:theme_id) { |n| n }
  end

  factory :user, class: User do
    sequence(:email)      { |n| "staff_user@example#{n}.com"}
    sequence(:first_name) { |n| "First Name #{n} "}
    sequence(:last_name)  { |n| "Last Name #{n}"}
    #sequence(:password)   {|n| "qwerty#{n}"}

    password              'password'
    password_salt         BCrypt::Engine.generate_salt
    password_digest       { BCrypt::Engine.hash_secret('password', password_salt) }
  end

  factory :webhook, class: Webhook do
    sequence(:address) { |n| "https://www.google.com.ua/"}
    sequence(:format)  { |n| "XML" }
    sequence(:topic)   { |n| Webhook::Topics::UPDATE_PRODUCT_EVENT}
  end
end
