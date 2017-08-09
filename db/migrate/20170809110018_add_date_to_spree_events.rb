class AddDateToSpreeEvents < ActiveRecord::Migration[5.1]
  def change
    add_column :spree_events, :date, :date
    add_column :spree_events, :time, :time
    add_column :spree_events, :recurring_monthly_event, :boolean, default: false
    add_column :spree_events, :recurring_weekly_event, :boolean, default: false
  end
end
