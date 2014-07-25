class AddCoursescheduleToClassrooms < ActiveRecord::Migration
  def change
    add_column :classrooms, :schedule, :string
  end
end
