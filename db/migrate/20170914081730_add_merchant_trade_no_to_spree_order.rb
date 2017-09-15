class AddMerchantTradeNoToSpreeOrder < ActiveRecord::Migration[5.1]
  def change
    add_column :spree_orders, :merchant_trade_no, :string
    add_column :spree_orders, :trade_no, :string
    add_column :spree_orders, :delivery_date, :datetime
    add_column :spree_orders, :time_of_day, :string


  end
end
