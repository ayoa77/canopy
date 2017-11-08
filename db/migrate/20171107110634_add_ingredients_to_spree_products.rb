class AddIngredientsToSpreeProducts < ActiveRecord::Migration[5.1]
     def change
    add_column(:spree_products, :ingredients, :string, default:"" )
  end
end
