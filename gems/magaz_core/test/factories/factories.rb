FactoryGirl.define do
  factory :article, class: MagazCore::Article do
    sequence(:title)   { |n| "Article #{n}" }
    sequence(:content) { |n| "Article #{n} content" }
  end

  factory :asset, class: MagazCore::Asset do
  end

  factory :blog, class: MagazCore::Blog do
    sequence(:title) { |n| "Blog #{n}" }
  end

  factory :collection, class: MagazCore::Collection do
    sequence(:name)        { |n| "Collection #{n}" }
    sequence(:description) { |n| "Collection #{n} description" }
  end

  factory :comment, class: MagazCore::Comment do
    sequence(:author) { |n| "author of comment #{n}" }
    sequence(:body)   { |n| "Comment #{n}" }
    sequence(:email)  { |n| "commenter#{n}@gmail.com" }
  end

  factory :checkout, class: MagazCore::Checkout do
  end

  factory :country, class: MagazCore::Country do
    sequence(:name) { |n| "FINLAND" }
    sequence(:code) { |n| "FI" }
  end

  factory :another_country, class: MagazCore::Country do
    sequence(:name) { |n| "POLAND" }
    sequence(:code) { |n| "PL" }
  end

  factory :customer, class: MagazCore::Customer do
    sequence(:email)  { |n| "customer#{n}@gmail.com" }
  end

  factory :email_template, class: MagazCore::EmailTemplate do
    sequence(:name)  { |n| "Order Notification"}
    sequence(:title) { |n| "New order"}
    sequence(:body)  { |n| "You have a new order"}
    sequence(:template_type)  { |n| "new_order_notification"}
  end

  factory :file, class: MagazCore::File do
    sequence(:name) {|n| "File #{n}"}
  end

  factory :link_list, class: MagazCore::LinkList do
    sequence(:name)  { |n| "List #{n}" }
  end

  factory :link, class: MagazCore::Link do
    sequence(:name)   { |n| "Link #{n}" }
  end

  factory :page, class: MagazCore::Page do
    sequence(:title)   { |n| "Title #{n}" }
    sequence(:content) { |n| "Content #{n}" }
  end

  factory :product, class: MagazCore::Product do
    sequence(:name)        { |n| "Example #{n}" }
    sequence(:description) { |n| "Example #{n} description" }
  end

  factory :product_image, class: MagazCore::ProductImage do
  end

  factory :shipping_country, class: MagazCore::ShippingCountry do
    sequence(:name) {|n| "UA"}
    sequence(:tax)  {|n| "1"}
  end

  factory :another_shipping_country, class: MagazCore::ShippingCountry do
    sequence(:name) {|n| "FI"}
    sequence(:tax)  {|n| "1"}
  end

  factory :shipping_rate, class: MagazCore::ShippingRate do
    sequence(:name)   { |n| "Shipping Rate #{n}" }
    sequence(:shipping_price) {123}
  end

  factory :shop, class: MagazCore::Shop do
    sequence(:name)      { |n| "Example#{n}" }
    sequence(:subdomain) { |n| "example#{n}" }
  end

  factory :subscriber_notification, class: MagazCore::SubscriberNotification do
    sequence(:notification_method) { |n| "email #{n}" }
    sequence(:subscription_address) { |n| "some1#{n}@here.run" }
  end

  factory :tax_override, class: MagazCore::TaxOverride do
    sequence(:rate) { |n| "#{n}"}
    sequence(:is_shipping) { |n| false }
  end

  factory :theme, class: MagazCore::Theme do
    sequence(:name)      { |n| "Theme#{n}" }
  end

  factory :user, class: MagazCore::User do
    sequence(:email)      {|n| "staff_user@example#{n}.com"}
    sequence(:first_name) {|n| "First Name #{n} "}
    sequence(:last_name)  {|n| "Last Name #{n}"}
    #sequence(:password)   {|n| "qwerty#{n}"}

    password 'password'
    password_salt BCrypt::Engine.generate_salt
    password_digest { BCrypt::Engine.hash_secret('password', password_salt) }
  end
end