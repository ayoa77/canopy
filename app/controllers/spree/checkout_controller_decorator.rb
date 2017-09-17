Spree::CheckoutController.class_eval do

def items_display(order)
  items_display = ""
  order.line_items.each do |li|
    items_display << li.name
    items_display << ' ' + li.variant.options_text
    items_display << 'x ' + li.quantity.to_s
    items_display << '@ $' + li.price.to_s[0..-3] + '#'
  end
  if items_display.length <= 200
    return items_display
  else
    items_display = ""
    order.line_items.each do |li|
      items_display << li.name
      items_display << ' x ' + li.quantity.to_s
      items_display << ' @ $' + li.price.to_s[0..-3] + '#'
    end
      if items_display.length <= 200
        return items_display
      else
        items_display = ""
        order.line_items.each do |li|
          items_display << li.name
          items_display << ' x ' + li.quantity.to_s + '#'
        end
        if items_display.length <= 200
          return items_display
        else
          items_display = "#{order.quantity} #{Spree.t(:juice)}"
            return items_display
          end
        end
      end
    end
end
