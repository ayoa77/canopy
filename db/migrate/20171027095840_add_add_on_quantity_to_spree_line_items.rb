class AddAddOnQuantityToSpreeLineItems < ActiveRecord::Migration[5.1]
  def change
    add_column :spree_line_items, :addon_quantity, :integer, default: "0", null: false
    add_column :spree_line_items, :addon_names, :string
    add_column :spree_line_items, :juice_names, :string
  end
end
