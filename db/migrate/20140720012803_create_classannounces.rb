class CreateClassannounces < ActiveRecord::Migration
  def change
    create_table :classannounces do |t|
      t.integer :user_id
      t.integer :classroom_id
      t.string :content

      t.timestamps
    end
    add_index :classannounces, :user_id
    add_index :classannounces, :classroom_id
  end
end
