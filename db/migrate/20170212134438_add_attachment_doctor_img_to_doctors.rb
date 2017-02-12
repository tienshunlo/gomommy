class AddAttachmentDoctorImgToDoctors < ActiveRecord::Migration
  def self.up
    change_table :doctors do |t|
      t.attachment :doctor_img
    end
  end

  def self.down
    remove_attachment :doctors, :doctor_img
  end
end
