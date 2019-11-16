class ShoppingCartController < ApplicationController
    skip_before_action :verify_authenticity_token
    def create
    end

    def index
        @cart = session[:shopping_cart] if session[:shopping_cart].present?
        @feature_ids = [];
        @cart.each_key {|key| @feature_ids.push(key)}

        @features = Feature.where(id: @feature_ids)
        @content = {
            feature: @features,
            quality: @cart,
        }
        render json: {:data => @content, :status => 200}
        
    end

    def add_to_cart
        @cart ||= {}
        @cart = session[:shopping_cart] if session[:shopping_cart].present?
        @feature = Feature.find(params[:id])
        @quality  = params[:quality]
        @new_hash = {@feature.id => @quality}
        @cart.merge!(@new_hash)
        session[:shopping_cart] = @cart
    end

    def remove_from_cart
        @cart = session[:shopping_cart] if session[:shopping_cart].present?
        @cart.delete(params[:id])
        session[:shopping_cart] = @cart
    end
end
