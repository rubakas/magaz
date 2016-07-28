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
    sequence(:first_name) {|n| "First Name #{n} "}
    sequence(:last_name)  {|n| "Last Name #{n}"}
    sequence(:email)  { |n| "customer#{n}@gmail.com" }
  end

  factory :email_template, class: EmailTemplate do
    sequence(:name)  { |n| "Order Notification"}
    sequence(:title) { |n| "New order"}
    sequence(:body)  { |n| "You have a new order"}
    sequence(:template_type)  { |n| "new_order_notification"}
    sequence(:description) { |n| "some description"}
  end

  factory :event, class: Event do
    sequence(:message) { |n| "User created a product: "}
    sequence(:verb) { |n| "create"}
    sequence(:arguments) {|n| "Product_Name"}
  end

  factory :file, class: AssetFile do
    sequence(:name) {|n| "File #{n}"}
  end

  factory :link_list, class: LinkList do
    sequence(:name)  { |n| "List #{n}" }
  end

  factory :link, class: Link do
    sequence(:name)   { |n| "Link #{n}" }
  end

  factory :partner, class: Partner do
    sequence(:name)   { |n| "Name#{n}" }
    sequence(:website_url) { |n| "https://site#{n}.com" }
  end

  factory :page, class: Page do
    sequence(:title)   { |n| "Title #{n}" }
    sequence(:content) { |n| "Content #{n}" }
    shop
  end

  factory :product, class: Product do
    sequence(:name)        { |n| "Example #{n}" }
    sequence(:description) { |n| "Example #{n} description" }
  end

  factory :product_image, class: ProductImage do
  end

  factory :shipping_country, class: ShippingCountry do
    sequence(:name) {|n| "UA"}
    sequence(:tax)  {|n| "#{n}"}
  end

  factory :shipping_rate, class: ShippingRate do
    sequence(:name)   { |n| "Shipping Rate #{n}" }
    sequence(:shipping_price) {123}
  end

  factory :shop, class: Shop do
    sequence(:name)      { |n| "Example#{n}" }
    sequence(:subdomain) { |n| "example#{n}" }
  end

  factory :subscriber_notification, class: SubscriberNotification do
    sequence(:notification_method) { |n| "email #{n}" }
    sequence(:subscription_address) { |n| "some1#{n}@here.run" }
  end

  factory :tax_override, class: TaxOverride do
    sequence(:rate) { |n| "#{n}"}
    sequence(:is_shipping) { |n| false }
  end

  factory :theme, class: Theme do
    sequence(:name)      { |n| "Theme#{n}" }
  end

  factory :theme_style, class: ThemeStyle do
    sequence(:name)      { |n| "Theme#{n}" }
    sequence(:theme_id)      { |n| n }
  end

  factory :user, class: User do
    sequence(:email)      {|n| "staff_user@example#{n}.com"}
    sequence(:first_name) {|n| "First Name #{n} "}
    sequence(:last_name)  {|n| "Last Name #{n}"}
    #sequence(:password)   {|n| "qwerty#{n}"}

    password 'password'
    password_salt BCrypt::Engine.generate_salt
    password_digest { BCrypt::Engine.hash_secret('password', password_salt) }
  end

  factory :webhook, class: Webhook do
    sequence(:address) { |n| "https://www.google.com.ua/"}
    sequence(:format)  { |n| "XML" }
    sequence(:topic)   {|n| Webhook::Topics::UPDATE_PRODUCT_EVENT}
  end
end
