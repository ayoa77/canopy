Spree::CheckoutController.class_eval do

  def edit
    #logic for individual items
    # if params[:state] == "delivery" && @order.quantity % 6 != 0 && @order.shipments.last.address.caddress1 != "宜蘭市女中路三段117號"
    #   flash[:info] = Spree.t(:sorry_you_must_order_multiples_of_six_to_to_have_them_shipped)
    #   redirect_to products_path and return
    # elsif params[:state] == "delivery" && @order.shipments.last.present? && @order.shipments.last.address.address1 == "宜蘭市女中路三段117號"
    #   @order.instore = true
    #   @order.save
    # elsif params[:state] == "delivery" && @order.shipments.last.present? && @order.shipments.last.address.address1 != "宜蘭市女中路三段117號"

    #   @order.instore = nil
    #   @order.save
    # end
      #     if params[:state] == "address" && @order.instore == true
      #   byebug
      #     @order.line_items.each do |li|
      #       if li.product.taxons.pluck(:name).include?("Delivery") && li.reduced != true
      #         li.adjustment_total -= 25
      #         li.reduced = true
      #         li.save
      #       end
      #       flash[:info] = Spree.t(:instore_pickup_receives_a_discount)
      #     end
      # elsif params[:state] == "address" && @order.instore != true
      #   byebug
      #     @order.line_items.each do |li|
      #       if li.product.taxons.pluck(:name).include?("Delivery") && li.reduced == true
      #         li.adjustment_total += 25
      #         li.reduced = false
      #         li.save
      #       end
      #     end
      #   end
    if @order.shipments.last.present? && @order.shipments.last.address.address1 == "宜蘭市女中路三段117號"
      @order.instore = true
      @order.save
    elsif @order.shipments.last.present? && @order.shipments.last.address.address1 != "宜蘭市女中路三段117號"
      @order.instore = nil
      @order.save
    end


  end

def items_display(order)
  items_display = ""
  addon_price = Spree::Product.find_by(description2: "addon").price || 20
  order.line_items.each do |li|
    unless li.hidden == true
    items_display << li.name
    items_display << ' ' + li.variant.options_text
    items_display << ' x ' + li.quantity.to_s
    items_display << ' @ $' + (li.price + addon_price * li.addon_quantity).to_s[0..-3] 
    items_display << ', ' + li.juice_names + ' #' if li.juice_names.present?
    items_display << ', ' + li.addon_names + ' #' if li.juice_names.present?
    items_display << ', ' + li.preference + ' #'
    end
  end
  if items_display.length <= 200
    return items_display
  else
    items_display = ""
    order.line_items.each do |li|
      unless li.hidden == true
      items_display << li.name
      items_display << ' x ' + li.quantity.to_s
      items_display << ' @ $' + (li.price + addon_price * li.addon_quantity).to_s[0..-3]  + '#'
      end
    end
      if items_display.length <= 200
        return items_display
      else
        items_display = ""
        order.line_items.each do |li|
          unless li.hidden == true
          items_display << li.name
          items_display << ' x ' + li.quantity.to_s + '#'
          end
        end
        if items_display.length <= 200
          return items_display
        else
          items_display = "#{order.quantity} #{Spree.t(:boxes)}"
            return items_display
          end
        end
      end
    end
end
