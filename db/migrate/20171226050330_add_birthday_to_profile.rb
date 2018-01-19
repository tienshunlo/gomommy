class AddBirthdayToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :birthday_of_baby, :datetime
  end
end
