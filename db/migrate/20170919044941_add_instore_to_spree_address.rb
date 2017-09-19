class AddInstoreToSpreeAddress < ActiveRecord::Migration[5.1]
  def change
    add_column :spree_addresses, :instore, :boolean, default: false
  end
end
