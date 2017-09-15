require 'allpay_payment'
module Spree
  # This is somewhat contrary to standard REST convention since there is not
  # actually a Checkout object. There's enough distinct logic specific to
  # checkout which has nothing to do with updating an order that this approach
  # is waranted.
  class CheckoutController < Spree::StoreController
    skip_before_action :verify_authenticity_token, :only => :notify
    before_action :load_order_with_lock
    before_action :ensure_valid_state_lock_version, only: [:update]
    before_action :set_state_if_present

    before_action :ensure_order_not_completed
    before_action :ensure_checkout_allowed
    before_action :ensure_sufficient_stock_lines
    before_action :ensure_valid_state

    before_action :associate_user
    before_action :check_authorization

    before_action :setup_for_current_state
    before_action :add_store_credit_payments, only: [:update]

    helper 'spree/orders'

    rescue_from Spree::Core::GatewayError, with: :rescue_from_spree_gateway_error

    # Updates the order and advances to the next state (when possible.)
    def update
      if params[:order][:payments_attributes].present? && Spree::PaymentMethod.find(params[:order][:payments_attributes].first[:payment_method_id]).name == "Credit Allpay"
           aioall(@order)
      else
      if @order.update_from_params(params, permitted_checkout_attributes, request.headers.env)
        @order.temporary_address = !params[:save_user_address]
        unless @order.next
          flash[:error] = @order.errors.full_messages.join("\n")
          redirect_to(checkout_state_path(@order.state)) && return
        end

        if @order.completed?
          byebug
          @current_order = nil
          flash.notice = Spree.t(:order_processed_successfully)
          flash['order_completed'] = true
          redirect_to completion_route
        else
          redirect_to checkout_state_path(@order.state)
        end
      else
        render :edit
      end
    end
  end

  def aioall(order)
      order.merchant_trade_no << Time.now.to_i.to_s
      order.trade_description = order.created_at.strftime("%Y%m%d").to_s + order.number
      order.save
      byebug
    ## 參數值為[PLEASE MODIFY]者，請在每次測試時給予獨特值
    ## 若要測試非必帶參數請將base_param內註解的參數依需求取消註解 ##
    base_param = {
      'MerchantTradeNo' => order.merchant_trade_no.last,  #請帶20碼uid, ex: f0a0d7e9fae1bb72bc93
      'MerchantTradeDate' => order.created_at.strftime("%Y/%m/%d %H:%M:%S"), # ex: 2017/02/13 15:45:30
      'TotalAmount' => order.total.to_i,
      'TradeDesc' => order.trade_description,
      'ItemName' => order.products.pluck(:name).join("#"),
      'ReturnURL' => "#{root_url}allpay_return",
      #'ChooseSubPayment' => '',
      'OrderResultURL' => "#{root_url}allpay_return",
      #'NeedExtraPaidInfo' => '1',
      'ClientBackURL' => "#{root_url}"
      #'ItemURL' => 'http://item.test.tw',
      #'Remark' => '交易備註',
      #'HoldTradeAMT' => '1',
      #'UseRedeem' => 'N'
    }


    ## 若要測試開立電子發票，請將inv_params內的"所有"參數取消註解 ##
    inv_params = {
=begin
      'RelateNumber' => 'PLEASE MODIFY',  #請帶30碼uid ex: SJDFJGH24FJIL97G73653XM0VOMS4K
      'CustomerID' => 'MEM_0000001',  #會員編號
      'CustomerIdentifier' => '',   #統一編號
      'CustomerName' => '測試買家',
      'CustomerAddr' => '測試用地址',
      'CustomerPhone' => '0123456789',
      'CustomerEmail' => 'johndoe@test.com',
      'ClearanceMark' => '2',
      'TaxType' => '1',
      'CarruerType' => '',
      'CarruerNum' => '',
      'Donation' => '2',
      'LoveCode' => '',
      'Print' => '1',
      'InvoiceItemName' => '測試商品1|測試商品2',
      'InvoiceItemCount' => '2|3',
      'InvoiceItemWord' => '個|包',
      'InvoiceItemPrice' => '35|10',
      'InvoiceItemTaxType' => '1|1',
      'InvoiceRemark' => '測試商品1的說明|測試商品2的說明',
      'DelayDay' => '0',
      'InvType' => '07'
=end
    }

    create = AllpayPayment::PaymentClient.new

    htm = create.aio_check_out_credit_onetime(params: base_param, invoice: inv_params)

    render html: htm.html_safe
  end

  def notify
    Spree::Order.where(state: "payment").each do |o|
      if o.merchant_trade_no.include?(pay_params[:MerchantTradeNo])
        @order = o
        break
      end
    end
    # @order = Spree::Order.find_by(trade_description: pay_params[:TradeDesc])
    @order.trade_no = pay_params[:TradeNo]
      if pay_params[:RtnCode] == '1'
        Spree::Payment.create(amount: pay_params[:PayAmt], order_id: @order.id, payment_method_id: Spree::PaymentMethod.all.find_by(name: "Credit Allpay").id, state: "checkout")
        # ActiveMerchant::Billing::Response.new(true, "", {}, {})
        @order.payment_total = pay_params[:PayAmt]
        @order.state = "payment"
      else
      Spree::Payment.create(amount: 0, order_id: @order.id, payment_method_id: Spree::PaymentMethod.all.find_by(name: "Credit Allpay").id, state: "failed")
    end
    @order.save
    unless @order.next
      flash[:error] = @order.errors.full_messages.join("\n")
      redirect_to(checkout_state_path(@order.state)) && return
    end
    if @order.completed?
      @order.payments.last.state = "completed"
      @current_order = nil
      flash.notice = Spree.t(:order_processed_successfully)
      flash['order_completed'] = true
      redirect_to completion_route
    else
      redirect_to checkout_state_path(@order.state)
    end
end
    # ActiveMerchant::Billing::Response.new(true, 'success', {}, {})
  def pay_params
    params.permit(:MerchantID, :MerchantTradeNo, :PayAmt, :PaymentDate, :PaymentType, :PaymentTypeChargeFee, :RedeemAmt, :RtnCode, :RtnMsg, :SimulatePaid, :TradeAmt, :TradeDate, :TradeNo, :CheckMacValue)

  end

  # Parameters {"MerchantID"=>"2000132", "MerchantTradeNo"=>"aa59161286d23c52420b", "PayAmt"=>"100",
  # "PaymentDate"=>"2017/09/14 13:31:20", "PaymentType"=>"Credit_CreditCard", "PaymentTypeChargeFee"=>"2",
  # "RedeemAmt"=>"0", "RtnCode"=>"1", "RtnMsg"=>"Succeeded", "SimulatePaid"=>"0", "TradeAmt"=>"100",
  # "TradeDate"=>"2017/09/14 13:30:49", "TradeNo"=>"1709141330498619",
  # "CheckMacValue"=>"F3AB99474E1466F3FA0ADE1B6ADB5078E8C54AD34FB3F44978DE3C3FECF4238D",
  # "controller"=>"spree/allpay", "action"=>"notify"}

    private

    def unknown_state?
      (params[:state] && !@order.has_checkout_step?(params[:state])) ||
        (!params[:state] && !@order.has_checkout_step?(@order.state))
    end

    def insufficient_payment?
      params[:state] == "confirm" &&
        @order.payment_required? &&
        @order.payments.valid.sum(:amount) != @order.total
    end

    def correct_state
      if unknown_state?
        @order.checkout_steps.first
      elsif insufficient_payment?
        'payment'
      else
        @order.state
      end
    end

    def ensure_valid_state
      if @order.state != correct_state && !skip_state_validation?
        flash.keep
        @order.update_column(:state, correct_state)
        redirect_to checkout_state_path(@order.state)
      end
    end

    # Should be overriden if you have areas of your checkout that don't match
    # up to a step within checkout_steps, such as a registration step
    def skip_state_validation?
      false
    end

    def load_order_with_lock
      @order = current_order(lock: true)
      redirect_to(spree.cart_path) && return unless @order
    end

    def ensure_valid_state_lock_version
      if params[:order] && params[:order][:state_lock_version]
        @order.with_lock do
          unless @order.state_lock_version == params[:order].delete(:state_lock_version).to_i
            flash[:error] = Spree.t(:order_already_updated)
            redirect_to(checkout_state_path(@order.state)) && return
          end
          @order.increment!(:state_lock_version)
        end
      end
    end

    def set_state_if_present
      if params[:state]
        if @order.can_go_to_state?(params[:state]) && !skip_state_validation?
          redirect_to checkout_state_path(@order.state)
        end
        @order.state = params[:state]
      end
    end

    def ensure_checkout_allowed
      unless @order.checkout_allowed?
        redirect_to spree.cart_path
      end
    end

    def ensure_order_not_completed
      redirect_to spree.cart_path if @order.completed?
    end

    def ensure_sufficient_stock_lines
      if @order.insufficient_stock_lines.present?
        flash[:error] = Spree.t(:inventory_error_flash_for_insufficient_quantity)
        redirect_to spree.cart_path
      end
    end

    # Provides a route to redirect after order completion
    def completion_route(custom_params = nil)
      spree.order_path(@order, custom_params)
    end

    def setup_for_current_state
      method_name = :"before_#{@order.state}"
      send(method_name) if respond_to?(method_name, true)
    end

    def before_address
      # if the user has a default address, a callback takes care of setting
      # that; but if he doesn't, we need to build an empty one here
      @order.bill_address ||= Address.build_default
      @order.ship_address ||= Address.build_default if @order.checkout_steps.include?('delivery')
    end

    def before_delivery
      return if params[:order].present?

      packages = @order.shipments.map(&:to_package)
      @differentiator = Spree::Stock::Differentiator.new(@order, packages)
    end

    def before_payment
      if @order.checkout_steps.include? "delivery"
        packages = @order.shipments.map(&:to_package)
        @differentiator = Spree::Stock::Differentiator.new(@order, packages)
        @differentiator.missing.each do |variant, quantity|
          @order.contents.remove(variant, quantity)
        end
      end

      if try_spree_current_user && try_spree_current_user.respond_to?(:payment_sources)
        @payment_sources = try_spree_current_user.payment_sources
      end
    end

    def add_store_credit_payments
      if params.has_key?(:apply_store_credit)
        @order.add_store_credit_payments

        # Remove other payment method parameters.
        params[:order].delete(:payments_attributes)
        params[:order].delete(:existing_card)
        params.delete(:payment_source)

        # Return to the Payments page if additional payment is needed.
        if @order.payments.valid.sum(:amount) < @order.total
          redirect_to checkout_state_path(@order.state) and return
        end
      end
    end

    def rescue_from_spree_gateway_error(exception)
      flash.now[:error] = Spree.t(:spree_gateway_error_flash_for_checkout)
      @order.errors.add(:base, exception.message)
      render :edit
    end

    def check_authorization
      authorize!(:edit, current_order, cookies.signed[:guest_token])
    end



  end
end
