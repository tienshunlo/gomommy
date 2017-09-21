class Addphasecateidtophase < ActiveRecord::Migration
  def change
    add_column :phases, :phasecate_id, :integer
  end
end
