class RemoveMerchantTradeNoFromSpreeOrders < ActiveRecord::Migration[5.1]
    def up
      if column_exists?(:spree_orders, :merchant_trade_no, :string)
        remove_column :spree_orders, :merchant_trade_no, :string
      end
    end

    def down
      unless column_exists?(:spree_orders, :merchant_trade_no, :string)
        add_column :spree_orders, :merchant_trade_no, :string
      end
    end
end
