class AddAttachmentPhoto1Photo2Photo3Photo4ToCustoms < ActiveRecord::Migration[5.1]
  def self.up
    change_table :spree_customs do |t|
      t.attachment :photo1
      t.attachment :photo2
      t.attachment :photo3
      t.attachment :photo4
    end
  end

  def self.down
    remove_attachment :spree_customs, :photo1
    remove_attachment :spree_customs, :photo2
    remove_attachment :spree_customs, :photo3
    remove_attachment :spree_customs, :photo4
  end
end
