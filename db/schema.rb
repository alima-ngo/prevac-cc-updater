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

ActiveRecord::Schema.define(version: 20160914202844) do

  create_table "beneficiaries", primary_key: "PID", id: :string, limit: 8, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string  "Full_Name",                         limit: 200,             null: false
    t.string  "Prefecture",                        limit: 250,             null: false
    t.string  "Sub_Prefecture",                    limit: 250,             null: false
    t.string  "Village",                           limit: 200
    t.string  "Phone_Number_1",                    limit: 9,               null: false
    t.string  "Phone_Number_2",                    limit: 9
    t.string  "Email",                             limit: 200
    t.string  "Full_Name_Additional_Contact_1",    limit: 200,             null: false
    t.string  "Information_Additional_Contact_1",  limit: 250,             null: false
    t.string  "Phone_Number_Additional_Contact_1", limit: 9
    t.string  "Full_Name_Additional_Contact_2",    limit: 200,             null: false
    t.string  "Information_Additional_Contact_2",  limit: 250,             null: false
    t.string  "Phone_Number_Additional_Contact_2", limit: 9
    t.integer "Day_Of_Birth"
    t.integer "Month_Of_Birth"
    t.integer "Year_Of_Birth",                                             null: false
    t.string  "Gender",                            limit: 10,              null: false
    t.integer "Age",                                                       null: false
    t.string  "Manual_No_Hit",                     limit: 10
    t.integer "Fales_Attempts",                                default: 0
    t.string  "Operator",                          limit: 200,             null: false
    t.integer "Duplicated",                                    default: 0
    t.date    "Date_Of_Update"
    t.time    "Time_Of_Update"
    t.integer "Exclude",                                       default: 0
    t.date    "Date_Of_Exclude"
    t.time    "Time_Of_Excluse"
    t.index ["Prefecture"], name: "PREFECTURE_BENEFICIARIES_FK_idx", using: :btree
    t.index ["Sub_Prefecture"], name: "SUB_PREFECTURE_BENEFICIARIES_FK_idx", using: :btree
  end

  create_table "beneficiaries_unexcpeted_visits", primary_key: ["PID", "Date_Of_Visit"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string  "PID",                   limit: 8,              null: false
    t.date    "Date_Of_Visit",                                null: false
    t.integer "Originating_Procedure"
    t.integer "Visit_Type",                       default: 8, null: false
    t.string  "Operator",              limit: 45
    t.time    "Time_Of_Visit"
    t.index ["PID"], name: "Beneficiaries_Unexpected_Visit", using: :btree
  end

  create_table "beneficiaries_visits", primary_key: ["PID", "Visit_Type"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string  "PID",                   limit: 8,              null: false
    t.integer "Visit_Type",                                   null: false
    t.date    "Start_From",                                   null: false
    t.date    "End_In",                                       null: false
    t.date    "Date_Of_Visit"
    t.integer "Visit_Flag",                       default: 0
    t.integer "Originating_Procedure"
    t.string  "Operator",              limit: 45
    t.time    "Time_Of_Visit"
    t.index ["PID"], name: "Beneficiaries_Visits_FK", using: :btree
  end

  create_table "beneficiary_exclude_log", primary_key: ["PID", "Date_Of_Exclude", "Time_Of_Exclude"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string  "PID",             limit: 8,   null: false
    t.string  "Operator",        limit: 100, null: false
    t.integer "Operator_ID",                 null: false
    t.string  "Operation",       limit: 45,  null: false
    t.date    "Date_Of_Exclude",             null: false
    t.time    "Time_Of_Exclude",             null: false
    t.index ["PID"], name: "PID_excluded_log", using: :btree
  end

  create_table "beneficiary_update_log", primary_key: ["PID", "Date_Of_Update", "Time_Of_Update"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string  "PID",            limit: 8,   null: false
    t.string  "Operator",       limit: 100, null: false
    t.integer "Operator_ID",                null: false
    t.date    "Date_Of_Update",             null: false
    t.time    "Time_Of_Update",             null: false
    t.index ["PID"], name: "PID_updated_log", using: :btree
  end

  create_table "commcare_updates", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.datetime "cc_update_on"
    t.integer  "progress"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "control_originating_procedures", primary_key: "ID", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "EN_Description", limit: 45, null: false
    t.string "FR_Description", limit: 45, null: false
  end

  create_table "enrollment_data", primary_key: "PID", id: :string, limit: 8, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string  "Enrollement_Site",   limit: 48, null: false
    t.date    "Date_Of_Enrollment",            null: false
    t.string  "TID",                limit: 48, null: false
    t.string  "Operator_ID",        limit: 48, null: false
    t.string  "Paper_File_Number",  limit: 48, null: false
    t.integer "Morpho_Number",                 null: false
    t.time    "Time_Of_Visit"
    t.index ["PID"], name: "Enrollment_Data_FK", using: :btree
  end

  create_table "prefecture", primary_key: "Name", id: :string, limit: 250, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
  end

  create_table "sub_prefecture", primary_key: ["Prefecture", "Sub_Prefecture"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "Prefecture",     limit: 250, null: false
    t.string "Sub_Prefecture", limit: 250, null: false
  end

  create_table "upload_download", primary_key: "TID", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.date "upload_day"
    t.time "upload_time"
    t.date "download_day"
    t.time "download_time"
  end

  create_table "visits_type", primary_key: "ID", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "EN_Description", limit: 200, null: false
    t.string "FR_Description", limit: 200, null: false
  end

  add_foreign_key "beneficiaries_unexcpeted_visits", "beneficiaries", column: "PID", primary_key: "PID", name: "Beneficiaries_Unexpected_Visit"
  add_foreign_key "beneficiaries_visits", "beneficiaries", column: "PID", primary_key: "PID", name: "Beneficiaries_Visits_FK"
  add_foreign_key "beneficiary_exclude_log", "beneficiaries", column: "PID", primary_key: "PID", name: "PID_excluded_log"
  add_foreign_key "beneficiary_update_log", "beneficiaries", column: "PID", primary_key: "PID", name: "PID_updated_log"
  add_foreign_key "enrollment_data", "beneficiaries", column: "PID", primary_key: "PID", name: "Enrollment_Data_FK"
  add_foreign_key "sub_prefecture", "prefecture", column: "Prefecture", primary_key: "Name", name: "PREFECTURE_SUB_PREFECTURE_FK"
end
