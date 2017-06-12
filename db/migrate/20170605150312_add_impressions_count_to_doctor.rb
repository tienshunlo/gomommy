class AddImpressionsCountToDoctor < ActiveRecord::Migration
  def change
    add_column :doctors, :impressions_count, :int
  end
end
