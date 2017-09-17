class AddDeliveryDateToSpreeShipment < ActiveRecord::Migration[5.1]
  def change
    add_column :spree_shipments, :delivery_date, :datetime
    add_column :spree_shipments, :time_of_day, :string
  end
end
