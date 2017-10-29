class ChangeSpreeLineItemPreferenceToString < ActiveRecord::Migration[5.1]
  def change
    change_column(:spree_line_items, :preference, :string, limit: 255)
  end
end
