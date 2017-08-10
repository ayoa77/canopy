module Spree
  class Event < Spree::Base
    has_attached_file :event_photo,
    styles: { mini: '48x48>', small: '100x100>', product: '240x240>', large: '600x600>' }

def filter_events(events)
  events.each do |e|
    if e.date < Time.now + 1.day && e.recurring_monthly_event == false && e.recurring_weekly_event == false
      e.delete
    elsif e.date < Time.now + 1.day && e.recurring_monthly_event == true && e.recurring_weekly_event == false
      e.date = e.date + 1.month
      e.save
    elsif e.date < Time.now + 1.day && e.recurring_monthly_event == false && e.recurring_weekly_event == true
      e.date = e.date + 1.week
      e.save
    end
  end

end



validates_attachment_content_type :event_photo, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
  end
end
