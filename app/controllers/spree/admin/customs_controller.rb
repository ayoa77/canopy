module Spree
  module Admin
    class CustomsController < ResourceController
      # before_action :load_form_data, only: [:new, :edit]

  def index
    @custom = Spree::Custom.first
  end

  def show
    @custom = Spree::Custom.first
  end

  def new
    @custom = Spree::Custom.new
  end

  def create
    @custom = Spree::Custom.create(custom_params)
    if @custom.save
        redirect_back fallback_location: root_path
    else
      render 'edit'
    end
  end

  def edit
    @custom = Spree::Custom.first
  end

  def update
    @custom = Spree::Custom.first
    if @custom.update(custom_params)
      redirect_to @custom
    else
      render 'edit'
    end
  end

  def destroy
    @custom.destroy
    redirect_to custom_new_path
  end

  private

  def custom_params
    params.require(:custom).permit(:about1, :about2, :about3, :about4, :photo1, :photo2, :photo3, :photo5, :photo6, :photo7, :photo8)
  end




    end
  end
end
