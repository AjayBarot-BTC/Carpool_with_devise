class AddTimeToRequests < ActiveRecord::Migration
  def change
    add_column :requests, :time, :string
  end
end
