class AddAttachmentPictureToDogs < ActiveRecord::Migration
  def self.up
    change_table :dogs do |t|
      t.attachment :picture
    end
  end

  def self.down
    drop_attached_file :dogs, :picture
  end
end
