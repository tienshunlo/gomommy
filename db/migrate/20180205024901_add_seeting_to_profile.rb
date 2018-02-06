class AddSeetingToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :setting, :text
  end
end
