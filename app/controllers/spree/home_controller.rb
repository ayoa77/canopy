module Spree
  class HomeController < Spree::StoreController
    helper 'spree/products'
    respond_to :html

    def index
      ##### these queries will work when there is a search bar and params #####
      # @searcher = build_searcher(params.merge(include_images: true))
      # @products = @searcher.retrieve_products
      # @products = @products.includes(:possible_promotions) if @products.respond_to?(:includes)
      ##### these queries will work when there are more than four products ideall with featured taxons/taxonomies #####

      # @products = Spree::Product.all
      # @taxonomies = Spree::Taxonomy.includes(root: :children)
      # @featured =  Spree::Product.joins(:taxons).includes(:taxons).where(spree_taxons: { name: "Featured"})
      # random_products = @products.shuffle

      # if @featured.first.nil?
      #   @featured_one = random_products.first
      # else
      #   @featured_one = @featured.first
      # end

      # if @featured.second.nil?
      #   @featured_two = random_products.second
      # else
      #   @featured_two = @featured.second
      # end

      # if @featured.third.nil?
      #   @featured_three = random_products.third
      # else
      #   @featured_three  = @featured.third
      # end

      # if @featured.fourth.nil?
      #   @featured_four = random_products.fourth
      # else
      #   @featured_four = @featured.fourth
      # end

      @red_box =  Spree::Product.joins(:taxons).includes(:taxons).where(spree_taxons: { name: "first"}).first
      @green_box =  Spree::Product.joins(:taxons).includes(:taxons).where(spree_taxons: { name: "second"}).first
      @yellow_box =  Spree::Product.joins(:taxons).includes(:taxons).where(spree_taxons: { name: "third"}).first
    end
  end
end
