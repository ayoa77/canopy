module Spree
  class EventsController < Spree::StoreController
    def index
      @events = Spree::Event.all
      @events = filter_events(@events)
      @events = @events.sort_by &:date

    end

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
          return events
        end
      end
    end
  end
end
