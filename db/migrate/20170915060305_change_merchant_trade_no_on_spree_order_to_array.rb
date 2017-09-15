class ChangeMerchantTradeNoOnSpreeOrderToArray < ActiveRecord::Migration[5.1]
  def change
    change_column :spree_orders, :merchant_trade_no, "varchar[] USING (string_to_array(merchant_trade_no, ','))"
  end
end
