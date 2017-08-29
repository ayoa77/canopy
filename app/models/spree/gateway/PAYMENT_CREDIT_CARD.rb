class OffsitePayments::Integrations::Allpay::PAYMENT_CREDIT_CARD < Spree::Gateway
  def provider_class
    ActiveMerchant::Billing::Integrations::Allpay
  end

  def payment_source_class
    Spree::CreditCard
  end

  def method_type
    'PAYMENT_CREDIT_CARD'
  end

  def purchase(amount, transaction_details, options = {})
    ActiveMerchant::Billing::Response.new(true, 'success', {}, {})
  end
end
