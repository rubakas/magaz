# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150324140737) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "articles", force: :cascade do |t|
    t.string   "title"
    t.text     "content"
    t.integer  "blog_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "handle"
    t.string   "page_title"
    t.string   "meta_description"
    t.string   "slug"
    t.datetime "publish_on"
    t.datetime "published_at"
  end

  create_table "assets", force: :cascade do |t|
    t.integer  "theme_id"
    t.string   "content_type"
    t.string   "key"
    t.string   "public_url"
    t.integer  "size"
    t.string   "src"
    t.string   "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "blogs", force: :cascade do |t|
    t.string   "title"
    t.integer  "shop_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "handle"
    t.string   "page_title"
    t.string   "meta_description"
    t.string   "slug"
  end

  create_table "checkouts", force: :cascade do |t|
    t.text     "note"
    t.string   "status"
    t.string   "financial_status"
    t.string   "fulfillment_status"
    t.string   "currency"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "customer_id"
  end

  create_table "collections", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "shop_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "handle"
    t.string   "page_title"
    t.string   "meta_description"
    t.string   "slug"
    t.datetime "publish_on"
    t.datetime "published_at"
  end

  create_table "collections_products", force: :cascade do |t|
    t.integer "collection_id"
    t.integer "product_id"
  end

  create_table "comments", force: :cascade do |t|
    t.string   "author"
    t.text     "body"
    t.string   "email"
    t.integer  "blog_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "article_id"
  end

  create_table "countries", force: :cascade do |t|
    t.string "name", limit: 50
    t.string "code", limit: 2
  end

  create_table "customers", force: :cascade do |t|
    t.boolean "accepts_marketing"
    t.string  "email"
    t.string  "first_name"
    t.string  "last_name"
    t.integer "shop_id"
  end

  create_table "email_templates", force: :cascade do |t|
    t.string   "name"
    t.string   "title"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "shop_id"
    t.string   "template_type"
    t.string   "description"
  end

  create_table "files", force: :cascade do |t|
    t.string   "file"
    t.string   "name"
    t.integer  "shop_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "file_size"
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "line_items", force: :cascade do |t|
    t.integer  "checkout_id"
    t.integer  "product_id"
    t.string   "name"
    t.text     "description"
    t.decimal  "price",       precision: 38, scale: 2
    t.integer  "quantity"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "link_lists", force: :cascade do |t|
    t.string  "name"
    t.integer "shop_id"
    t.string  "handle"
    t.string  "slug"
  end

  add_index "link_lists", ["slug"], name: "index_link_lists_on_slug", unique: true, using: :btree

  create_table "links", force: :cascade do |t|
    t.string  "name"
    t.string  "link_type"
    t.integer "position"
    t.string  "subject"
    t.string  "subject_params"
    t.integer "subject_id"
    t.integer "link_list_id"
  end

  create_table "order_subscriptions", force: :cascade do |t|
    t.string   "notification_method"
    t.string   "subscription_address"
    t.integer  "shop_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pages", force: :cascade do |t|
    t.string   "title"
    t.string   "content"
    t.integer  "shop_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "handle"
    t.string   "page_title"
    t.string   "meta_description"
    t.string   "slug"
    t.datetime "publish_on"
    t.datetime "published_at"
  end

  create_table "product_images", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image"
    t.integer  "product_id"
  end

  create_table "products", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "shop_id"
    t.decimal  "price",            precision: 38, scale: 2
    t.string   "handle"
    t.string   "page_title"
    t.string   "meta_description"
    t.string   "slug"
    t.datetime "publish_on"
    t.datetime "published_at"
  end

  create_table "shipping_countries", force: :cascade do |t|
    t.string  "name"
    t.string  "tax"
    t.integer "shop_id"
    t.integer "country_id"
  end

  create_table "shipping_rates", force: :cascade do |t|
    t.string   "name"
    t.string   "criteria"
    t.float    "price_from"
    t.float    "price_to"
    t.float    "weight_from"
    t.float    "weight_to"
    t.float    "shipping_price"
    t.integer  "shipping_country_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "shops", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_salt"
    t.string   "subdomain"
    t.string   "address"
    t.string   "business_name"
    t.string   "city"
    t.string   "country"
    t.string   "currency"
    t.string   "customer_email"
    t.string   "phone"
    t.string   "province"
    t.string   "timezone"
    t.string   "unit_system"
    t.integer  "zip"
    t.string   "handle"
    t.string   "page_title"
    t.string   "meta_description"
    t.string   "account_type_choice"
    t.boolean  "billing_address_is_shipping_too"
    t.string   "abandoned_checkout_time_delay"
    t.string   "email_marketing_choice"
    t.string   "after_order_paid"
    t.boolean  "after_order_fulfilled_and_paid"
    t.string   "checkout_language"
    t.text     "checkout_refund_policy"
    t.text     "checkout_privacy_policy"
    t.text     "checkout_term_of_service"
    t.boolean  "enable_multipass_login"
    t.boolean  "notify_customers_of_their_shipment"
    t.boolean  "automatically_fulfill_all_orders"
    t.string   "authorization_settings"
    t.boolean  "all_taxes_are_included"
    t.boolean  "charge_taxes_on_shipping_rates"
    t.integer  "eu_digital_goods_collection_id"
  end

  create_table "tax_overrides", force: :cascade do |t|
    t.float   "rate"
    t.boolean "is_shipping",         default: false
    t.integer "collection_id"
    t.integer "shipping_country_id"
  end

  create_table "themes", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "shop_id"
    t.integer  "source_theme_id"
    t.string   "role"
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "password_digest"
    t.string   "phone"
    t.string   "homepage"
    t.string   "bio"
    t.integer  "shop_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "user_type"
    t.string   "password_salt"
    t.boolean  "account_owner",   default: false
    t.string   "permissions",     default: [],    array: true
    t.string   "invite_token"
  end

end
