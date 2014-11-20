class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :title
      t.text :content
      t.date :date
      t.integer :user_id

      t.timestamps
    end
  end
end
