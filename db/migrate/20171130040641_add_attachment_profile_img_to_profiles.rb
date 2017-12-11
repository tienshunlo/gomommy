class AddAttachmentProfileImgToProfiles < ActiveRecord::Migration
  def self.up
    change_table :profiles do |t|
      t.attachment :profile_img
    end
  end

  def self.down
    remove_attachment :profiles, :profile_img
  end
end
