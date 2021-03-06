class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

rescue_from ActiveRecord::RecordNotFound, :with => :rescue404
rescue_from ActionController::RoutingError, :with => :rescue404

# $addon_price = Spree::Product.find_by(description2: "addon").price || 20
#
  def rescue404
    render 'public/404'
  end

end
