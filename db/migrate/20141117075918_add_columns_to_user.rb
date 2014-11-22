class AddColumnsToUser < ActiveRecord::Migration
  def change
    add_column :users, :firstname, :string
    add_column :users, :lastname, :string
    add_column :users, :activated, :boolean
    add_column :users, :deceased, :boolean
    add_column :users, :gem, :integer
    add_column :users, :facebook_api_key, :string
  end
end
