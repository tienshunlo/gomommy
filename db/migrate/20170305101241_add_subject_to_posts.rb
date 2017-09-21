class AddSubjectToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :subject, :integer
    add_column :posts, :period, :integer
    add_column :posts, :kind, :integer
  end
end
