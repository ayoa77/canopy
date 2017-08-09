class CreateSpreeCustom < ActiveRecord::Migration[5.1]
  def change
    create_table :spree_customs do |t|
      t.string :about1
      t.string :about2
      t.string :about3
      t.string :about4
    end
  end
end
