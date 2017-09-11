class ChangeProductsDynamicVariantsToTrue < ActiveRecord::Migration[5.1]
  def change
    change_column :spree_products, :dynamic_variants, :boolean, :default => true
  end
  Spree::Product.all.each do |p| p.dynamic_variants = true
    p.save
  end
end
