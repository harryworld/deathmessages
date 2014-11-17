class AddDeceasedToUser < ActiveRecord::Migration
  def change
    add_column :users, :deceased, :boolean
  end
end
