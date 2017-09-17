class AddMerchantTradeNoToSpreePayment < ActiveRecord::Migration[5.1]
  def change
    add_column :spree_payments, :merchant_trade_no, :string
    add_column :spree_payments, :trade_no, :string
  end
end
