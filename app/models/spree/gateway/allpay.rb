module Spree
  class Gateway::Allpay < Gateway
    preference :account, :string
    preference :password, :string
    preference :merchant_id, :string
    preference :hash_key, :string
    preference :hash_iv, :string
    preference :server, :select, default: -> { { values: [:test, :production] } }
    preference :pass_billing_and_shipping_address, :boolean_select, default: false
    preference :return_url, :string
    preference :notify_url, :boolean_select, default: false
    preference :descriptor_name, :string
    preference :currency_merchant_accounts, :hash, default: {}

    def provider_class
        OffsitePayments::Integrations::Allpay
    end

    def provider_class_helper
      provider_class::Helper
    end

    def purchase(amount, transaction_details, gateway_options={} )
      OffsitePayments::Integrations::Allpay::Notification.new
    end
  end
end
