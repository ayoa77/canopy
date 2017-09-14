require 'allpay_payment'

module Spree
 class AllpayController < Spree::StoreController
  skip_before_action :verify_authenticity_token, :only => :notify

  def aioall
    @order.find(params[:id])
@order.merchant_trade_no = @order.create_at.strftime("%Y-%m-%d").to_s + @order.number
@order.save
    ## 參數值為[PLEASE MODIFY]者，請在每次測試時給予獨特值
    ## 若要測試非必帶參數請將base_param內註解的參數依需求取消註解 ##
    base_param = {
      'MerchantTradeNo' => @order.merchant_trade_no,  #請帶20碼uid, ex: f0a0d7e9fae1bb72bc93
      'MerchantTradeDate' => @order.created_at.to_s, # ex: 2017/02/13 15:45:30
      'TotalAmount' => @order.total.to_i,
      'TradeDesc' => '測試交易描述',
      'ItemName' => @order.products.pluck(:name).join("#"),
      'ReturnURL' => "#{root_url}/allpay_return",
      #'ChooseSubPayment' => '',
      'OrderResultURL' => "#{root_url}/allpay_return",
      #'NeedExtraPaidInfo' => '1',
      'ClientBackURL' => "#{root_url}/allpay_return"
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
    byebug
    @order = Spree::Order.find_by(merchant_trade_no: pay_params[:MerchantTradeNo])
    @order.trade_no = pay_params[:TradeNo]
    if pay_params[:RtnCode] == '1'
      @order.payment_total = pay_params[:PayAmt]
    end
    @order.save
    byebug
    redirect_to update_checkout_path(@order.state)
    # ActiveMerchant::Billing::Response.new(true, 'success', {}, {})
  end
  def pay_params
    params.permit(:MerchantID, :MerchantTradeNo, :PayAmt, :PaymentDate, :PaymentType, :PaymentTypeChargeFee, :RedeemAmt, :RtnCode, :RtnMsg, :SimulatePaid, :TradeAmt, :TradeDate, :TradeNo, :CheckMacValue)

end

  # Parameters {"MerchantID"=>"2000132", "MerchantTradeNo"=>"aa59161286d23c52420b", "PayAmt"=>"100",
  # "PaymentDate"=>"2017/09/14 13:31:20", "PaymentType"=>"Credit_CreditCard", "PaymentTypeChargeFee"=>"2",
  # "RedeemAmt"=>"0", "RtnCode"=>"1", "RtnMsg"=>"Succeeded", "SimulatePaid"=>"0", "TradeAmt"=>"100",
  # "TradeDate"=>"2017/09/14 13:30:49", "TradeNo"=>"1709141330498619",
  # "CheckMacValue"=>"F3AB99474E1466F3FA0ADE1B6ADB5078E8C54AD34FB3F44978DE3C3FECF4238D",
  # "controller"=>"spree/allpay", "action"=>"notify"}
end
end
