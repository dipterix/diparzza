class CreateStaffs < ActiveRecord::Migration
  def change
    create_table :staffs do |t|
      t.boolean :isactive
      t.boolean :issuper
      t.boolean :isadmin

      t.timestamps
    end
  end
end
