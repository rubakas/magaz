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

ActiveRecord::Schema.define(version: 20140412230645) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "articles", force: true do |t|
    t.string   "title",            limit: 255
    t.text     "content"
    t.integer  "blog_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "handle",           limit: 255
    t.string   "page_title",       limit: 255
    t.string   "meta_description", limit: 255
    t.string   "slug",             limit: 255
  end

  create_table "blogs", force: true do |t|
    t.string   "title",            limit: 255
    t.integer  "shop_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "handle",           limit: 255
    t.string   "page_title",       limit: 255
    t.string   "meta_description", limit: 255
    t.string   "slug",             limit: 255
  end

  create_table "checkouts", force: true do |t|
    t.text     "note"
    t.string   "status",             limit: 255
    t.string   "financial_status",   limit: 255
    t.string   "fulfillment_status", limit: 255
    t.string   "currency",           limit: 255
    t.string   "email",              limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "customer_id"
  end

  create_table "collections", force: true do |t|
    t.string   "name",             limit: 255
    t.text     "description"
    t.integer  "shop_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "handle",           limit: 255
    t.string   "page_title",       limit: 255
    t.string   "meta_description", limit: 255
    t.string   "slug",             limit: 255
  end

  create_table "collections_products", force: true do |t|
    t.integer "collection_id"
    t.integer "product_id"
  end

  create_table "comments", force: true do |t|
    t.string   "author",     limit: 255
    t.text     "body"
    t.string   "email",      limit: 255
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
    t.string   "slug",           limit: 255, null: false
    t.integer  "sluggable_id",               null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope",          limit: 255
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "line_items", force: true do |t|
    t.integer  "checkout_id"
    t.integer  "product_id"
    t.string   "name",        limit: 255
    t.text     "description"
    t.decimal  "price",                   precision: 38, scale: 2
    t.integer  "quantity"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pages", force: true do |t|
    t.string   "title",            limit: 255
    t.string   "content",          limit: 255
    t.integer  "shop_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "handle",           limit: 255
    t.string   "page_title",       limit: 255
    t.string   "meta_description", limit: 255
    t.string   "slug",             limit: 255
  end

  create_table "product_images", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image",      limit: 255
    t.integer  "product_id"
  end

  create_table "products", force: true do |t|
    t.string   "name",             limit: 255
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "shop_id"
    t.decimal  "price",                        precision: 38, scale: 2
    t.string   "handle",           limit: 255
    t.string   "page_title",       limit: 255
    t.string   "meta_description", limit: 255
    t.string   "slug",             limit: 255
  end

  create_table "shops", force: true do |t|
    t.string   "email",           limit: 255
    t.string   "name",            limit: 255
    t.string   "password_digest", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_salt",   limit: 255
    t.string   "subdomain",       limit: 255
  end

end
