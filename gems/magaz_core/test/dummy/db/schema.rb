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

ActiveRecord::Schema.define(version: 20140416153636) do

  create_table "articles", force: true do |t|
    t.string   "title"
    t.text     "content"
    t.integer  "blog_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "handle"
    t.string   "page_title"
    t.string   "meta_description"
    t.string   "slug"
  end

  create_table "assets", force: true do |t|
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

  create_table "blogs", force: true do |t|
    t.string   "title"
    t.integer  "shop_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "handle"
    t.string   "page_title"
    t.string   "meta_description"
    t.string   "slug"
  end

  create_table "checkouts", force: true do |t|
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

  create_table "collections", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "shop_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "handle"
    t.string   "page_title"
    t.string   "meta_description"
    t.string   "slug"
  end

  create_table "collections_products", force: true do |t|
    t.integer "collection_id"
    t.integer "product_id"
  end

  create_table "comments", force: true do |t|
    t.string   "author"
    t.text     "body"
    t.string   "email"
    t.integer  "blog_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "article_id"
  end

  create_table "customers", force: true do |t|
    t.boolean "accepts_marketing"
    t.string  "email"
    t.string  "first_name"
    t.string  "last_name"
    t.integer "shop_id"
  end

  create_table "friendly_id_slugs", force: true do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"

  create_table "line_items", force: true do |t|
    t.integer  "checkout_id"
    t.integer  "product_id"
    t.string   "name"
    t.text     "description"
    t.decimal  "price",       precision: 38, scale: 2
    t.integer  "quantity"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pages", force: true do |t|
    t.string   "title"
    t.string   "content"
    t.integer  "shop_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "handle"
    t.string   "page_title"
    t.string   "meta_description"
    t.string   "slug"
  end

  create_table "product_images", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image"
    t.integer  "product_id"
  end

  create_table "products", force: true do |t|
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
  end

  create_table "shops", force: true do |t|
    t.string   "email"
    t.string   "name"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_salt"
    t.string   "subdomain"
  end

  create_table "themes", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "shop_id"
    t.integer  "source_theme_id"
    t.string   "role"
  end

end