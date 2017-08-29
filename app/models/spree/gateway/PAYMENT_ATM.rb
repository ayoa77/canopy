class OffsitePayments::Integrations::Allpay::PAYMENT_ATM < Spree::Gateway
  def provider_class
    OffsitePayments::Integrations::Allpay::PAYMENT_ATM
  end

  def method_type
    'PAYMENT_ATM'
  end

  def purchase(amount, transaction_details, options = {})
    ActiveMerchant::Billing::Response.new(true, 'success', {}, {})
  end
end
