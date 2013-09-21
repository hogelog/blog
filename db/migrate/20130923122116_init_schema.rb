class InitSchema < ActiveRecord::Migration
  def change
    create_table "articles", force: true do |t|
      t.integer  "user_id"
      t.string   "title"
      t.text     "text"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "comments", force: true do |t|
      t.integer  "article_id"
      t.text     "text"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    add_index "comments", ["article_id"], name: "index_comments_on_article_id"

    create_table "users", force: true do |t|
      t.string   "username"
      t.string   "password"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    add_index "users", ["username"], name: "index_users_on_username", unique: true
  end
end
