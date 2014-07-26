class AddEnrollconditionToClassrooms < ActiveRecord::Migration
  def change
    add_column :classrooms, :condition, :string
  end
end
