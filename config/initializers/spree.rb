# Configure Spree Preferences
#
# Note: Initializing preferences available within the Admin will overwrite any changes that were made through the user interface when you restart.
#       If you would like users to be able to update a setting with the Admin it should NOT be set here.
#
# Note: If a preference is set here it will be stored within the cache & database upon initialization.
#       Just removing an entry from this initializer will not make the preference value go away.
#       Instead you must either set a new value or remove entry, clear cache, and remove database entry.
#
# In order to initialize a setting do:
# config.setting_name = 'new value'
Spree.config do |config|

  config.default_country_id = 227
  # Example:
  # Uncomment to stop tracking inventory levels in the application


  config.track_inventory_levels = false
end

Rails.application.config.spree.payment_methods  << Spree::Gateway::Allpay

# Rails.application.config.spree.payment_methods << OffsitePayments::Integrations::Allpay::PAYMENT_CREDIT_CARD
# Rails.application.config.spree.payment_methods << OffsitePayments::Integrations::Allpay::PAYMENT_ATM
# Rails.application.config.spree.payment_methods << OffsitePayments::Integrations::Allpay::PAYMENT_CVS

Spree.user_class = "Spree::User"
