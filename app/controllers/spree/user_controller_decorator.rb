Spree::UsersController.class_eval do

  def update
   
    if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end
  
    if params[:user][:ship_address_attributes].present?
        @user.ship_address.update!(zipcode: params[:user][:ship_address_attributes][:zipcode], city: params[:user][:ship_address_attributes][:city], address2: params[:user][:ship_address_attributes][:address2], address1: params[:user][:ship_address_attributes][:address1], lastname: params[:user][:ship_address_attributes][:lastname], firstname: params[:user][:ship_address_attributes][:firstname], phone: params[:user][:ship_address_attributes][:phone])
    end
    
    if @user.update_attributes(user_params)
      flash.now[:success] = Spree.t(:account_updated)
      render :show and return
    end

    render :edit
  end
end
