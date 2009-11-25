class CreateReminder < ActiveRecord::Migration
  def self.up
    create_table :reminders do |t|
      t.date :date
      t.integer :time
      t.integer :item_id
      t.string :item_type

      t.timestamps
    end
  end

  def self.down
    drop_table :reminders
  end
end