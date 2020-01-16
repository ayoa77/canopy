




















































Spree.routes.clear_cache = Spree.adminPathFor('general_settings/clear_cache')
Spree.routes.checkouts_api = Spree.pathFor('api/v1/checkouts')
Spree.routes.classifications_api = Spree.pathFor('api/v1/classifications')
Spree.routes.option_types_api = Spree.pathFor('api/v1/option_types')
Spree.routes.option_values_api = Spree.pathFor('api/v1/option_values')
Spree.routes.orders_api = Spree.pathFor('api/v1/orders')
Spree.routes.products_api = Spree.pathFor('api/v1/products')
Spree.routes.shipments_api = Spree.pathFor('api/v1/shipments')
Spree.routes.checkouts_api = Spree.pathFor('api/v1/checkouts')
Spree.routes.stock_locations_api = Spree.pathFor('api/v1/stock_locations')
Spree.routes.taxon_products_api = Spree.pathFor('api/v1/taxons/products')
Spree.routes.taxons_api = Spree.pathFor('api/v1/taxons')
Spree.routes.users_api = Spree.pathFor('api/v1/users')
Spree.routes.tags_api = Spree.pathFor('api/v1/tags')
Spree.routes.variants_api = Spree.pathFor('api/v1/variants')

Spree.routes.edit_product = function(product_id) {
  return Spree.adminPathFor('products/' + product_id + '/edit')
}

Spree.routes.payments_api = function(order_id) {
  return Spree.pathFor('api/v1/orders/' + order_id + '/payments')
}

Spree.routes.stock_items_api = function(stock_location_id) {
  return Spree.pathFor('api/v1/stock_locations/' + stock_location_id + '/stock_items')
}
