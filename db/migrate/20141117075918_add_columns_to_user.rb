class AddColumnsToUser < ActiveRecord::Migration
  def change
    add_column :users, :lastname, :string
    add_column :users, :lastname, :string
    add_column :users, :activated, :boolean
    add_column :users, :deceased, :boolean
  end
end
