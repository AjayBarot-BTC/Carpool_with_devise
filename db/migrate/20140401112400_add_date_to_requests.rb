class AddDateToRequests < ActiveRecord::Migration
  def change
    add_column :requests, :date, :string
  end
end
