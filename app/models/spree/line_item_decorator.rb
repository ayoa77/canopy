
Spree::LineItem.class_eval do

Spree::PermittedAttributes.line_item_attributes << :preference
Spree::PermittedAttributes.line_item_attributes << :addon_names
Spree::PermittedAttributes.line_item_attributes << :addon_quantity
Spree::PermittedAttributes.line_item_attributes << :juice_names

end