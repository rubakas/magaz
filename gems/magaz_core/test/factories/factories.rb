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

  factory :customer, class: MagazCore::Customer do
    sequence(:email)  { |n| "customer#{n}@gmail.com" }
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

  factory :shop, class: MagazCore::Shop do
    sequence(:name)      { |n| "Example#{n}" }
    sequence(:subdomain) { |n| "example#{n}" }
    sequence(:email)     { |n| "admin@example#{n}.com" }

    password 'password'
    password_salt BCrypt::Engine.generate_salt
    password_digest { BCrypt::Engine.hash_secret('password', password_salt) }
  end

  factory :theme, class: MagazCore::Theme do
    sequence(:name)      { |n| "Theme#{n}" }
  end
end