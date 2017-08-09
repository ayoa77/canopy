class AddAttachmentEventPhotoToEvents < ActiveRecord::Migration[5.1]
  def self.up
    change_table :spree_events do |t|
      t.attachment :event_photo
    end
  end

  def self.down
    remove_attachment :spree_events, :event_photo
  end
end
