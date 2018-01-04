class AddGenderToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :number_of_baby, :integer, default: 0
    add_column :profiles, :nickname_of_baby, :string
    add_column :profiles, :gender_of_baby, :integer, default: 0
  end
end
