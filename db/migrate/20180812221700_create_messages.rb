class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :content
      t.references :recipient, index: true
      t.references :sender, index: true
      t.references :conversation, index: true

      t.timestamps null: false
    end
  end
end
