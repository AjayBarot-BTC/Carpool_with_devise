class AddContentToRequests < ActiveRecord::Migration
  def change
    add_column :requests, :content, :string
  end
end
