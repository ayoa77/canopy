class AddReducedToSpreeLineItems < ActiveRecord::Migration[5.1]
  def change
    add_column :spree_line_items, :reduced, :boolean, default: false
  end
end
