class AddPreferenceToSpreeLineItems < ActiveRecord::Migration[5.1]
  def change
    add_column :spree_line_items, :preference, :text, array: true, default: [], using: "(string_to_array(preference, ','))"
  end
end
