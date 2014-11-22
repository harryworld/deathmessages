class AddFacebookApiKeyToUser < ActiveRecord::Migration
  def change
    add_column :users, :facebook_api_key, :string
  end
end
