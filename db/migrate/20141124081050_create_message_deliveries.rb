class CreateMessageDeliveries < ActiveRecord::Migration
  def change
    create_table :message_deliveries do |t|
      t.date :unlock_date, :default => nil
      t.integer :user_id
      t.integer :message_id

      t.timestamps
    end
  end
end
