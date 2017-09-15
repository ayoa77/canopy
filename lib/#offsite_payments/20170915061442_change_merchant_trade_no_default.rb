# class ChangeMerchantTradeNoDefault < ActiveRecord::Migration[5.1]
#   def change
#     change_column :spree_orders, :merchant_trade_no, :text, array: true, default: [], using: "(string_to_array(merchant_trade_no, ','))"
#   end
# end
