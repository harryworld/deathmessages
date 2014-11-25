class AddColumnsToUser < ActiveRecord::Migration
  def change
    add_column :users, :firstname, :string
    add_column :users, :lastname, :string
    add_column :users, :activated, :boolean, :default => false
    add_column :users, :deceased, :boolean, :default => false
    add_column :users, :credit, :integer, :default => 0
    add_column :users, :facebook_api_key, :string
  end
end
