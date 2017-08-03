module Spree
  class HomeController < Spree::StoreController
    helper 'spree/products'
    respond_to :html

    def index
      @searcher = build_searcher(params.merge(include_images: true))
      @products = @searcher.retrieve_products
      @products = @products.includes(:possible_promotions) if @products.respond_to?(:includes)
      @taxonomies = Spree::Taxonomy.includes(root: :children)
      @featured =  Spree::Product.joins(:taxons).includes(:taxons).where(spree_taxons: { name: "Featured"})
      if @featured.nil?
        @featured = Spree::Product.all
      end
    end
  end
end
