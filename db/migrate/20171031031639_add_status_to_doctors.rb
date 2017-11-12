class AddStatusToDoctors < ActiveRecord::Migration
  def change
    add_column :doctors, :status, :integer, default: 0
  end
end
