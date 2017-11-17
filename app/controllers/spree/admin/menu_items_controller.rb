module Spree
  module Admin
    class MenuItemsController < ResourceController
      # before_action :load_form_data, only: [:new, :edit]
      # t.string "name"
      # t.string "location"
      # t.string "description"
      # t.string "price"
      # t.string "menuitem_photo_file_name"
      # t.string "menuitem_photo_content_type"
      # t.integer "menuitem_photo_file_size"
      # t.datetime "menuitem_photo_updated_at"
      # t.date "date"
      # t.time "time"
      # t.boolean "recurring_monthly_menuitem", default: false
      # t.boolean "recurring_weekly_menuitem", default: false

  def index
    @menuitems = Spree::MenuItem.all
    @menuitems = @menuitems.sort_by &:position
  end

  def show
    @menuitem = Spree::MenuItem.find(params[:id])
  end

  def new
    @menuitem = Spree::MenuItem.new
  end

  def create
    @menuitem = Spree::MenuItem.create(menuitem_params)
    if @menuitem.save
      redirect_to '/admin/menuitems'
    else
      render 'new'
    end
  end

  def edit
    @menuitem = Spree::MenuItem.find(params[:id])
  end

  def update
    @menuitem = Spree::MenuItem.find(params[:id])
    if @menuitem.update(menuitem_params)
      redirect_to '/admin/menuitems'
    else
      render 'edit'
    end
  end

  def destroy
    @menuitem.destroy
    redirect_to '/admin/menuitems'
  end

  private

  def menuitem_params
    params.require(:menuitem).permit(:id, :name, :location, :description, :price, :date, :time, :menuitem_photo, :recurring_weekly_menuitem, :recurring_monthly_menuitem)
  end
    end
  end
end
