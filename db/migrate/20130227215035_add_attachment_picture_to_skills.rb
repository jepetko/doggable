class AddAttachmentPictureToSkills < ActiveRecord::Migration
  def self.up
    change_table :skills do |t|
      t.attachment :picture
    end
  end

  def self.down
    drop_attached_file :skills, :picture
  end
end
