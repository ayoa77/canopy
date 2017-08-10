module Spree
  class EventsController < Spree::StoreController
    def index
      @events = Spree::Event.all.sort_by &:date

    end
  end
end
