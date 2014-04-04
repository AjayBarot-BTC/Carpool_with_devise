class AddRequestIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :request_id, :integer
  end
end
