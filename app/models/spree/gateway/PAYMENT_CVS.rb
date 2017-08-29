class OffsitePayments::Integrations::Allpay::PAYMENT_CVS < Spree::Gateway
  def provider_class
    OffsitePayments::Integrations::Allpay::PAYMENT_CVS
  end

  def method_type
    'PAYMENT_CVS'
  end

  def purchase(amount, transaction_details, options = {})
    ActiveMerchant::Billing::Response.new(true, 'success', {}, {})
  end
end
