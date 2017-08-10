module Spree
  class CustomController < Spree::StoreController


def about
  @custom = Spree::Custom.first
end

def instoreMenu
  @custom = Spree::Custom.first
end

def nutrition
  @products = Spree::Product.where.not(fiber: nil, carbs: nil, sugar: nil, fat: nil, sodium: nil, calories: nil, protein: nil)
  @products = @products.sort_by(&:name.downcase)
end

end
end
