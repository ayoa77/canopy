module Spree
  class CustomController < Spree::StoreController


def about
  @custom = Spree::Custom.first
end

def instoreMenu
  @custom = Spree::Custom.first
  @smoothies =  Spree::Product.joins(:taxons).includes(:taxons).where(spree_taxons: { name: "Smoothies"})
  @juices =  Spree::Product.joins(:taxons).includes(:taxons).where(spree_taxons: { name: "Juice"})
  @teas =  Spree::Product.joins(:taxons).includes(:taxons).where(spree_taxons: { name: "Tea"})
  @food =  Spree::Product.joins(:taxons).includes(:taxons).where(spree_taxons: { name: "Food"})
  @desserts =  Spree::Product.joins(:taxons).includes(:taxons).where(spree_taxons: { name: "Dessert"})
end

def nutrition
  @products = Spree::Product.where.not(fiber: nil, carbs: nil, sugar: nil, fat: nil, sodium: nil, calories: nil, protein: nil)
  @products = @products.sort_by(&:name.downcase)
end

end
end
