class ChangeSpreeLineItemDefaultPreferenceToString < ActiveRecord::Migration[5.1]
     def change
    change_column(:spree_line_items, :preference, :text, default: nil )
  end
end
