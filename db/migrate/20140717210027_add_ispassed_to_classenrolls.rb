class AddIspassedToClassenrolls < ActiveRecord::Migration
  def change
    add_column :classenrolls, :ispassed, :boolean
  end
end
