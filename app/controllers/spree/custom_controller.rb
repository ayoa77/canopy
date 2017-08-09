module Spree
  class CustomController < Spree::StoreController


def about
  @custom = Spree::Custom.first
end

def instoreMenu
end

def nutrition
  # @products = Spree::Product.where(carbs: !nil? && sugar: !nil? $$ fat: !nil? $$ sodium: !nil? $$ carbs: !nil? $$ calories: !nil? $$ sugar: !nil?)
  # @products = @products.sort_by(&:name.downcase)
end

end
end
