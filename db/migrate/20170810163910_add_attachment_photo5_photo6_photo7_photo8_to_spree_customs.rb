class AddAttachmentPhoto5Photo6Photo7Photo8ToSpreeCustoms < ActiveRecord::Migration[5.1]
  def self.up
    change_table :spree_customs do |t|
      t.attachment :photo5
      t.attachment :photo6
      t.attachment :photo7
      t.attachment :photo8
    end
  end

  def self.down
    remove_attachment :spree_customs, :photo5
    remove_attachment :spree_customs, :photo6
    remove_attachment :spree_customs, :photo7
    remove_attachment :spree_customs, :photo8
  end
end
