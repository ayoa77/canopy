module ErrorDefinition
  # Generic Allpay exception class.
  class AllpayError < StandardError; end
  class MissingOption < AllpayError; end
  class InvalidMode < AllpayError; end
  class InvalidParam < AllpayError; end
    class InvoiceRuleViolate < AllpayError; end
end