module Spree
  class ProductsController < Spree::StoreController
    before_action :load_product, only: :show
    before_action :load_taxon, only: :index

    rescue_from ActiveRecord::RecordNotFound, with: :render_404
    helper 'spree/taxons'

    respond_to :html

    def index
      @taxonomies = Spree::Taxonomy.includes(root: :children)
      if params[:categories] == "Smoothies"
        @products =  Spree::Product.joins(:taxons).includes(:taxons).where(spree_taxons: { name: "Smoothies"})
      elsif params[:categories] == "Juice"
        @products =  Spree::Product.joins(:taxons).includes(:taxons).where(spree_taxons: { name: "Juice"})
      elsif params[:categories] == "Tea"
        @products =  Spree::Product.joins(:taxons).includes(:taxons).where(spree_taxons: { name: "Tea"})
        else
        @searcher = build_searcher(params.merge(include_images: true))
        @products = @searcher.retrieve_products
        @products = @products.includes(:possible_promotions) if @products.respond_to?(:includes)
end


# = button_to "smth", some_path, method: :get, params: { start_point: 3.month.ago }
    end

    def show
      @variants = @product.variants_including_master.
                           spree_base_scopes.
                           active(current_currency).
                           includes([:option_values, :images])
      @product_properties = @product.product_properties.includes(:property)
      @taxon = params[:taxon_id].present? ? Spree::Taxon.find(params[:taxon_id]) : @product.taxons.first
      redirect_if_legacy_path
    end

    private

      def accurate_title
        if @product
          @product.meta_title.blank? ? @product.name : @product.meta_title
        else
          super
        end
      end

      def load_product
        if try_spree_current_user.try(:has_spree_role?, "admin")
          @products = Product.with_deleted
        else
          @products = Product.active(current_currency)
        end
        @product = @products.includes(:variants_including_master, variant_images: :viewable).friendly.find(params[:id])
      end

      def load_taxon
        @taxon = Spree::Taxon.find(params[:taxon]) if params[:taxon].present?
      end

      def redirect_if_legacy_path
        # If an old id or a numeric id was used to find the record,
        # we should do a 301 redirect that uses the current friendly id.
        if params[:id] != @product.friendly_id
          params[:id] = @product.friendly_id
          params.permit!
          return redirect_to url_for(params), status: :moved_permanently
        end
      end
  end
end
