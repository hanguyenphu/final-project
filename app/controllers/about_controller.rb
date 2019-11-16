class AboutController < ApplicationController
  def index
    @abouts = About.all
    # create_shopping_cart
    # @new_product_array = @cart.push(Feature.last);
    # session[:shopping_cart] = @new_product_array
    
    @product = session[:shopping_cart]

    @cart = session[:shopping_cart] if session[:shopping_cart].present?

    @feature_ids = [];
    @cart.each_key {|key| @feature_ids.push(key)}

    @features = Feature.where(id: @feature_ids)

  end

  def create_shopping_cart
    # @feature = Feature.first
    # @product_array = [@feature, @feature]
    # session[:shopping_cart] = @product_array 
    session[:shopping_cart] = {}
    @cart ||= {}
    @cart = session[:shopping_cart] if session[:shopping_cart].present?

    @feature = Feature.first
    @quality  = 2 
    @new_hash = {@feature.id => @quality}


    @cart.merge!(@new_hash)

    @feature = Feature.last
    @quality  = 2 
    @new_hash = {@feature.id => @quality}
    @cart.merge!(@new_hash)



    
    session[:shopping_cart] = @cart

end
end
