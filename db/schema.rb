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

ActiveRecord::Schema[7.0].define(version: 2024_05_05_181042) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "class_course_slots", force: :cascade do |t|
    t.bigint "dep_class_id", null: false
    t.bigint "slot_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "teacher_course_id"
    t.integer "days"
    t.index ["dep_class_id"], name: "index_class_course_slots_on_dep_class_id"
    t.index ["slot_id"], name: "index_class_course_slots_on_slot_id"
  end

  create_table "courses", force: :cascade do |t|
    t.string "courseName"
    t.integer "department_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["department_id"], name: "index_courses_on_department_id"
  end

  create_table "dep_classes", force: :cascade do |t|
    t.string "name"
    t.integer "room_id", null: false
    t.integer "department_id", null: false
    t.integer "strength"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "class_type"
    t.index ["department_id"], name: "index_dep_classes_on_department_id"
    t.index ["room_id"], name: "index_dep_classes_on_room_id"
  end

  create_table "departments", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "leave_requests", force: :cascade do |t|
    t.string "user_name"
    t.datetime "start_date"
    t.datetime "end_date"
    t.boolean "status"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "reason"
    t.index ["user_id"], name: "index_leave_requests_on_user_id"
  end

  create_table "makeups", force: :cascade do |t|
    t.integer "dep_class_id"
    t.integer "slot_id"
    t.integer "teacher_course_id"
    t.integer "days"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "status"
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_makeups_on_user_id"
  end

  create_table "rooms", force: :cascade do |t|
    t.string "name"
    t.integer "department_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["department_id"], name: "index_rooms_on_department_id"
  end

  create_table "slots", force: :cascade do |t|
    t.time "start_time"
    t.time "end_time"
    t.bigint "department_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["department_id"], name: "index_slots_on_department_id"
  end

  create_table "teacher_courses", force: :cascade do |t|
    t.integer "course_id", null: false
    t.integer "teacher_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_teacher_courses_on_course_id"
    t.index ["teacher_id"], name: "index_teacher_courses_on_teacher_id"
  end

  create_table "teachers", force: :cascade do |t|
    t.string "name"
    t.integer "department_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["department_id"], name: "index_teachers_on_department_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "username", default: "", null: false
    t.integer "roles", default: 0, null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.boolean "verified"
    t.integer "department_id"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "class_course_slots", "dep_classes"
  add_foreign_key "class_course_slots", "slots"
  add_foreign_key "courses", "departments"
  add_foreign_key "dep_classes", "departments"
  add_foreign_key "dep_classes", "rooms"
  add_foreign_key "leave_requests", "users"
  add_foreign_key "makeups", "users"
  add_foreign_key "rooms", "departments"
  add_foreign_key "slots", "departments"
  add_foreign_key "teacher_courses", "courses"
  add_foreign_key "teacher_courses", "teachers"
  add_foreign_key "teachers", "departments"
end
