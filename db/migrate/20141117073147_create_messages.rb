class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :title
      t.text :content
      t.string :photo
      t.date :send_date

      t.timestamps
    end
  end
end
