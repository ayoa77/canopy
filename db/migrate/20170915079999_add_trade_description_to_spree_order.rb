class AddTradeDescriptionToSpreeOrder < ActiveRecord::Migration[5.1]
  def change
    add_column :spree_orders, :trade_description, :string
  end
end
