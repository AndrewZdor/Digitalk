# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20090929141825) do

  create_table "assignments", :force => true do |t|
    t.integer  "user_id"
    t.integer  "entity_id"
    t.integer  "permission_mask",       :default => 0
    t.integer  "assigned_by_user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "security_subject_id"
    t.string   "security_subject_type"
  end

  create_table "blogs", :force => true do |t|
    t.integer  "project_id"
    t.string   "title"
    t.text     "description"
    t.datetime "published_date"
    t.boolean  "is_published"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "clients", :force => true do |t|
    t.integer  "mrc_id"
    t.string   "name"
    t.string   "address"
    t.string   "address2"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "phone"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "entities", :force => true do |t|
    t.string   "name"
    t.integer  "parent_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "mrcs", :force => true do |t|
    t.string   "name"
    t.string   "address"
    t.string   "address2"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "phone"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "project_groups", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "projects", :force => true do |t|
    t.integer  "client_id"
    t.string   "title"
    t.text     "description"
    t.date     "start_date"
    t.date     "end_date"
    t.boolean  "display"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "surveys", :force => true do |t|
    t.integer  "project_id"
    t.string   "title"
    t.text     "description"
    t.datetime "published_date"
    t.boolean  "is_approved"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_groupings", :force => true do |t|
    t.integer  "group_user_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "project_id"
    t.integer  "project_group_id"
  end

  create_table "users", :force => true do |t|
    t.string   "login",                     :limit => 40,  :default => "",    :null => false
    t.string   "first_name",                :limit => 100, :default => ""
    t.string   "last_name",                 :limit => 100, :default => ""
    t.string   "crypted_password",          :limit => 40,  :default => "",    :null => false
    t.string   "salt",                      :limit => 40
    t.string   "phone"
    t.string   "mobile"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token",            :limit => 40
    t.datetime "remember_token_expires_at"
    t.boolean  "is_group",                                 :default => false
    t.boolean  "is_admin"
  end

  add_index "users", ["login"], :name => "index_users_on_login", :unique => true

end
