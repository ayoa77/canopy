class AddPersistingQuantityToSpreeLineItems < ActiveRecord::Migration[5.1]
  def change
    add_column :spree_line_items, :old_quantity, :integer, default: "0", null: false
  end
end
