# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_03_08_074648) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "authors", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "degree"
    t.text "content"
    t.boolean "active", default: true
    t.text "product_content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "currencies", force: :cascade do |t|
    t.string "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ebook_authors", force: :cascade do |t|
    t.bigint "ebook_id", null: false
    t.bigint "author_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_id"], name: "index_ebook_authors_on_author_id"
    t.index ["ebook_id"], name: "index_ebook_authors_on_ebook_id"
  end

  create_table "ebook_prices", force: :cascade do |t|
    t.decimal "base_price", precision: 10, scale: 2
    t.decimal "price", precision: 10, scale: 2
    t.bigint "currency_id", null: false
    t.bigint "ebook_id", null: false
    t.date "valid_from"
    t.date "valid_to"
    t.boolean "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["currency_id"], name: "index_ebook_prices_on_currency_id"
    t.index ["ebook_id"], name: "index_ebook_prices_on_ebook_id"
  end

  create_table "ebooks", force: :cascade do |t|
    t.string "title"
    t.string "original_title"
    t.string "subtitle"
    t.string "short_content"
    t.text "content"
    t.text "anotation"
    t.string "video"
    t.string "isbn"
    t.string "isbn_epub"
    t.string "isbn_mobi"
    t.string "isbn_pdf"
    t.bigint "series_id", null: false
    t.integer "percentage_preview"
    t.bigint "language_id", null: false
    t.datetime "activate_at"
    t.datetime "change_at"
    t.boolean "active"
    t.string "internal_number"
    t.bigint "publisher_id", null: false
    t.integer "part"
    t.integer "publication_year"
    t.integer "page_count"
    t.integer "publication_place"
    t.datetime "licence_end_at"
    t.datetime "sale_start_at"
    t.datetime "sale_end_at"
    t.string "url"
    t.boolean "sponsored"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "confirmed", default: false
    t.index ["language_id"], name: "index_ebooks_on_language_id"
    t.index ["publisher_id"], name: "index_ebooks_on_publisher_id"
    t.index ["series_id"], name: "index_ebooks_on_series_id"
  end

  create_table "exchange_rates", force: :cascade do |t|
    t.bigint "currency_id", null: false
    t.decimal "ex_rate"
    t.integer "quantity"
    t.date "valid_from"
    t.date "valid_to"
    t.boolean "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["currency_id"], name: "index_exchange_rates_on_currency_id"
  end

  create_table "languages", force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.string "url"
    t.boolean "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "currency_id"
    t.index ["currency_id"], name: "index_languages_on_currency_id"
  end

  create_table "publishers", force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.string "address"
    t.string "url"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "series", force: :cascade do |t|
    t.string "title"
    t.string "subtitle"
    t.text "short_content"
    t.text "content"
    t.string "video"
    t.string "isbn_epub"
    t.string "isbn_mobi"
    t.string "isbn_pdf"
    t.boolean "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "publisher_id"
    t.string "first_name"
    t.string "last_name"
    t.integer "role", default: 0
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["publisher_id"], name: "index_users_on_publisher_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "ebook_authors", "authors"
  add_foreign_key "ebook_authors", "ebooks"
  add_foreign_key "ebook_prices", "currencies"
  add_foreign_key "ebook_prices", "ebooks"
  add_foreign_key "ebooks", "languages"
  add_foreign_key "ebooks", "publishers"
  add_foreign_key "ebooks", "series"
  add_foreign_key "exchange_rates", "currencies"
end
