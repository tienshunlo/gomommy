class AddPhaseIdToPost < ActiveRecord::Migration
  def change
    add_column :posts, :phase_id, :integer
  end
end
