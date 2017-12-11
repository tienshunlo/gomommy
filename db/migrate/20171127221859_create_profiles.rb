class CreateProfiles < ActiveRecord::Migration
  def change
    create_table(:profiles, id: false) do |t|
      t.references :user, index: true, foreign_key: true, unique: true
      t.string :location
      t.timestamps null: false
    end
  end
end
