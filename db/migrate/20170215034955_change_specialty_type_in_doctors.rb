class ChangeSpecialtyTypeInDoctors < ActiveRecord::Migration
 
    
  def up
    change_table :doctors do |t|
      t.change :specialty, :text
      t.change :experience, :text
    end
  end
 
  def down
    change_table :doctors do |t|
      t.change :specialty, :string
      t.change :experience, :string
    end
  end
  
end
