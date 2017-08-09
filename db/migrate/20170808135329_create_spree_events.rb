class CreateSpreeEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :spree_events do |t|
      t.string :name
      t.string :location
      t.string :description
      t.string :price

      t.timestamps
    end
  end
end
