Spree::OrdersController.class_eval do  


  def variant_populate
    addon_variant = Spree::Product.find_by(description2: "addon").master
    order = current_order(create_order_if_necessary: true)
    product = Spree::Product.find(params[:product_id])
    option_values_ids = params[:options].present? ? params[:options] : []
    option_values = Spree::OptionValue.where(id: option_values_ids)
    variant = product.try_variant option_values
    quantity = params[:quantity].to_i
    preference = (params[:preference].length > 1 ? params[:preference] : Spree.t(:no_preference))
    addon_quantity = params[:addon_quantity]
    addon_names = params[:addon_names]
    juice_names = params[:juice_names]

    # 2,147,483,647 is crazy. See issue #2695.
    if quantity.between?(1, 1_000)
      begin
        li = order.line_items.create(variant_id: variant.id, quantity: quantity, old_quantity: quantity, preference: preference, addon_quantity: addon_quantity, addon_names: addon_names, juice_names: juice_names, hidden: false)
        order.item_count += quantity
        order.save
        if li.addon_quantity > 0 
          quantity.times do
            order.line_items.create(variant_id: addon_variant.id, quantity: addon_quantity, hidden: true, old_quantity: addon_quantity)
          end 
        end
        order.update_totals         
        order.persist_totals

        # order.line_items.last.preference << preference
        # order.line_items.last.save
       
     
      rescue ActiveRecord::RecordInvalid => e
        error = e.record.errors.full_messages.join(", ")
      end
    else
      error = Spree.t(:please_enter_reasonable_quantity)
    end

    if error
      flash[:error] = error
      redirect_back_or_default(spree.root_path)
    else
      respond_with(order) do |format|
        format.html { redirect_to cart_path }
        format.js
      end
    end
  end

    def result
    Spree::Order.where(state: "payment").each do |o|
      if o.merchant_trade_no.include?(pay_params[:MerchantTradeNo])
        @order = o
        break
      end
    end
    @order.trade_no = pay_params[:TradeNo]
      if pay_params[:RtnCode] == '1'
        Spree::Payment.create(amount: pay_params[:PayAmt], order_id: @order.id, payment_method_id: Spree::PaymentMethod.all.find_by(description: "credit card").id, state: "completed", merchant_trade_no: pay_params[:MerchantTradeNo] , trade_no: pay_params[:TradeNo])
        @order.payment_total = pay_params[:PayAmt]
      else
      Spree::Payment.create(amount: 0, order_id: @order.id, payment_method_id: Spree::PaymentMethod.all.find_by(description: "credit card").id, state: "failed", merchant_trade_no: pay_params[:MerchantTradeNo] , trade_no: pay_params[:TradeNo])
    end
    @order.save
  end

end
