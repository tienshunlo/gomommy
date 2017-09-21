class AddGenderToDoctors < ActiveRecord::Migration
  def change
    add_column :doctors, :gender, :integer, :limit => 1 , :default => 0 , :null => false , :unsigned => true
  end
end
