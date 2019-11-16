class ShoppingCartController < ApplicationController
    def create
    end

    def index
    end

    def add_to_cart
        @cart ||= {}
        @cart = session[:shopping_cart] if session[:shopping_cart].present?
        @feature = Feature.third
        @quality  = 10
        @new_hash = {@feature.id => @quality}
        @cart.merge!(@new_hash)
        session[:shopping_cart] = @cart
    end

    def remove_from_cart
        @cart = session[:shopping_cart] if session[:shopping_cart].present?
        @feature = Feature.find(params[:id])
        @cart.delete(@feature.id)
        session[:shopping_cart] = @cart
    end
end
