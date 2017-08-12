class AddInstoreToSpreeOrders < ActiveRecord::Migration[5.1]
  def change
    add_column :spree_orders, :instore, :boolean
  end
end
