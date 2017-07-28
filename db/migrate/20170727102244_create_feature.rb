class CreateFeature < ActiveRecord::Migration[5.1]
  def change
    create_table :features do |t|
      t.references :spree_product_id
      t.integer :key
    end
  end
end
