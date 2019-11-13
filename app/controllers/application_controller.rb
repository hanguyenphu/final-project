class ApplicationController < ActionController::Base
    include Pagy::Backend

    protected

    def configure_permitted_parameters
         devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :address, :province_id, :email, :password)}

         devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:name, :address, :province_id, :email, :password, :current_password)}
    end

    def create_shopping_cart
        session[:shopping_cart] = 'hello world' unless session[:shopping_cart].present 
    end
end
