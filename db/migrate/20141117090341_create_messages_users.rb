class CreateMessagesUsers < ActiveRecord::Migration
   def self.up
    create_table :messages_users, id: false do |t|
      t.integer :message_id
      t.integer :user_id
    end

    add_index :messages_users, [:message_id, :user_id]
  end

  def self.down
    drop_table :messages_users
  end
end
