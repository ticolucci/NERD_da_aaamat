class CreateRecord < ActiveRecord::Migration
  def self.up
    create_table :records do |t|
      t.string :title
      t.string :body
      t.belongs_to :subject

      t.timestamps
    end
  end

  def self.down
    drop_table :records
  end
end