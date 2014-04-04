class CreateSearches < ActiveRecord::Migration
  def change
    create_table :searches do |t|
      t.string :string
      t.integer :user_id
      t.integer :request_id

      t.timestamps
    end
    add_index :searches, :user_id, :unique => true
    add_index :searches, :request_id, :unique => true
    add_index :searches, [:user_id, :request_id], unique: true
  end
end
