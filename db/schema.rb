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

ActiveRecord::Schema.define(version: 20140728104026) do

  create_table "classannounces", force: true do |t|
    t.integer  "user_id"
    t.integer  "classroom_id"
    t.string   "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "classannounces", ["classroom_id"], name: "index_classannounces_on_classroom_id"
  add_index "classannounces", ["user_id"], name: "index_classannounces_on_user_id"

  create_table "classenrolls", force: true do |t|
    t.integer  "user_id"
    t.integer  "classroom_id"
    t.boolean  "ista"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "ispassed"
  end

  add_index "classenrolls", ["classroom_id"], name: "index_classenrolls_on_classroom_id"
  add_index "classenrolls", ["user_id"], name: "index_classenrolls_on_user_id"

  create_table "classrooms", force: true do |t|
    t.string   "num"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "intro"
    t.string   "schedule"
    t.boolean  "ispublic"
    t.string   "condition"
  end

  add_index "classrooms", ["user_id"], name: "index_classrooms_on_user_id"

  create_table "staffs", force: true do |t|
    t.boolean  "isactive"
    t.boolean  "issuper"
    t.boolean  "isadmin"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  add_index "staffs", ["user_id"], name: "index_staffs_on_user_id"

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "nickname"
    t.string   "realname"
    t.string   "institution"
    t.string   "dept"
    t.boolean  "status"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
