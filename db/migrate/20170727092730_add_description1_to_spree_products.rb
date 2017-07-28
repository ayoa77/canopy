class AddDescription1ToSpreeProducts < ActiveRecord::Migration[5.1]
  def change
    add_column :spree_products, :description1, :string
    add_column :spree_products, :description2, :string
    add_column :spree_products, :category, :string
  end
end
