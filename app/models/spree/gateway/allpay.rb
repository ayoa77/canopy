module Spree
  class Gateway::Allpay < Gateway
    preference :account, :string
    preference :password, :string

    def provider_class
        OffsitePayments::Integrations::Allpay
    end
  end
end
