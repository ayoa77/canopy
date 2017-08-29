require 'allpay_payment'

class YOURCONTROLLER < ApplicationController

  def AioChkATM
    ## 參數值為[PLEASE MODIFY]者，請在每次測試時給予獨特值
    ## 若要測試非必帶參數請將base_param內註解的參數依需求取消註解 ##
    base_param = {
      'MerchantTradeNo' => 'PLEASE MODIFY',  #請帶20碼uid, ex: f0a0d7e9fae1bb72bc93
      'MerchantTradeDate' => 'PLEASE MODIFY', # ex: 2017/02/13 15:45:30
      'TotalAmount' => '100',
      'TradeDesc' => '測試交易描述',
      'ItemName' => '測試商品等',
      'ReturnURL' => 'http://192.168.0.1'
      #'ChooseSubPayment' => '',
      #'OrderResultURL' => 'http://192.168.0.1/payment_result',
      #'NeedExtraPaidInfo' => '1',
      #'ClientBackURL' => 'https://www.google.com',
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

    pay_info_url = 'http://192.168.0.1'
    exp = '7'
    cli_redir_url 'http://192.168.0.1/payment_result'

    create = AllpayPayment::PaymentClient.new
    htm = create.aio_check_out_atm(params: base_param, url_return_payinfo: pay_info_url, exp_period: exp, client_redirect:cli_redir_url, invoice:inv_params)
    render :text => htm
  end
