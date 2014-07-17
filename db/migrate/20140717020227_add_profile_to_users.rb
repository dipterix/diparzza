class AddProfileToUsers < ActiveRecord::Migration
  def change
    add_column :users, :nickname, :string
    add_column :users, :realname, :string
    add_column :users, :institution, :string
    add_column :users, :dept, :string
    add_column :users, :status, :boolean
  end
end
