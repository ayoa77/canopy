Devise.secret_key = "9b0b73b165f0f13d12642509991cbea98f64043db00da029e3ae720b8974533115c84de14effd595fddae8b17c96f029d361"

Devise.setup do |config|
  # Required so users don't lose their carts when they need to confirm.
  config.allow_unconfirmed_access_for = 1.days

  # Fixes the bug where Confirmation errors result in a broken page.
  config.router_name = :spree

  # Add any other devise configurations here, as they will override the defaults provided by spree_auth_devise.
end
