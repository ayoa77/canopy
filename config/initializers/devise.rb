Devise.secret_key = "82477c1c8e3498fbf247cefb17c763d79864adea39e805b7dadc57840008197f2eff3314c53827a9dedf4e6c2ed647a76494"
Devise.setup do |config|
  # Required so users don't lose their carts when they need to confirm.
  config.allow_unconfirmed_access_for = 1.days

  # Fixes the bug where Confirmation errors result in a broken page.
  config.router_name = :spree

  # Add any other devise configurations here, as they will override the defaults provided by spree_auth_devise.
end
