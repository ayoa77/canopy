module Spree
  module Admin
    class EventsController < ResourceController
      # before_action :load_form_data, only: [:new, :edit]
      # t.string "name"
      # t.string "location"
      # t.string "description"
      # t.string "price"
      # t.string "event_photo_file_name"
      # t.string "event_photo_content_type"
      # t.integer "event_photo_file_size"
      # t.datetime "event_photo_updated_at"
      # t.date "date"
      # t.time "time"
      # t.boolean "recurring_monthly_event", default: false
      # t.boolean "recurring_weekly_event", default: false

  def index
    @events = Spree::Event.all
    @events.sort_by &:date
  end

  def show
    @event = Spree::Event.find(params[:id])
  end

  def new
    @event = Spree::Event.new
  end

  def create
    @event = Spree::Event.create(event_params)
    if @event.save
      redirect_to '/admin/events'
    else
      render 'new'
    end
  end

  def edit
    @event = Spree::Event.find(params[:id])
  end

  def update
    @event = Spree::Event.find(params[:id])
    if @event.update(event_params)
      redirect_to '/admin/events' 
    else
      render 'edit'
    end
  end

  def destroy
    @event.destroy
    redirect_to '/admin/events'
  end

  private

  def event_params
    params.require(:event).permit(:id, :name, :location, :description, :price, :date, :time, :event_photo, :recurring_weekly_event, :recurring_monthly_event)
  end




    end
  end
end
