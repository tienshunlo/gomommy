class CreatePhasecates < ActiveRecord::Migration
  def change
    create_table :phasecates do |t|
      t.string :title

      t.timestamps null: false
    end
  end
end
