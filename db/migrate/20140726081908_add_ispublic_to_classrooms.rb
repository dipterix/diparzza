class AddIspublicToClassrooms < ActiveRecord::Migration
  def change
    add_column :classrooms, :ispublic, :boolean
  end
end
