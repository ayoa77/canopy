class AddNutrientsToSpreeProducts < ActiveRecord::Migration[5.1]
  def change
    add_column :spree_products, :calories, :string
    add_column :spree_products, :protein, :string
    add_column :spree_products, :fat, :string
    add_column :spree_products, :sugar, :string
    add_column :spree_products, :fiber, :string
    add_column :spree_products, :sodium, :string
  end
end
