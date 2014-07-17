class AddIntroToClassrooms < ActiveRecord::Migration
  def change
    add_column :classrooms, :intro, :string
  end
end
