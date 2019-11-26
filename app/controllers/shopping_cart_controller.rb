# frozen_string_literal: true

class ShoppingCartController < ApplicationController
  skip_before_action :verify_authenticity_token
  def create; end

  def index
    @cart = session[:shopping_cart] if session[:shopping_cart].present?
    @feature_ids = []

    @cart&.each_key { |key| @feature_ids.push(key) }

    @features = Feature.where(id: @feature_ids)

    # @content = if !@features.empty?
    #              {
    #                feature: @features,
    #                quality: @cart,
    #                authenticated: user_signed_in?
    #              }
    #            else
    #              {
    #                feature: [],
    #                quality: [],
    #                authenticated: user_signed_in?
    #              }
    #            end

    # render json: { data: @content, status: 200 }
  end

  def add_quantity
    @cart ||= {}
    @cart = session[:shopping_cart] if session[:shopping_cart].present?
    @feature_id = params[:id]
    @quantity = params[:quantity].to_i + 1

    @new_hash = { @feature_id => @quantity }
    @cart.merge!(@new_hash)
    session[:shopping_cart] = @cart
    redirect_to '/shopping_cart/index'
  end

  def subtract_quantity
    @cart ||= {}
    @cart = session[:shopping_cart] if session[:shopping_cart].present?
    @feature_id = params[:id]
    @quantity = params[:quantity].to_i - 1
    @quantity = 1 if @quantity == 0
    @new_hash = { @feature_id => @quantity }
    @cart.merge!(@new_hash)
    session[:shopping_cart] = @cart
    redirect_to '/shopping_cart/index'
  end

  def add_to_cart
    @cart ||= {}
    @cart = session[:shopping_cart] if session[:shopping_cart].present?
    @feature = Feature.find(params[:id])
    @quality = params[:quality]
    @new_hash = { @feature.id => @quality }
    @cart.merge!(@new_hash)
    session[:shopping_cart] = @cart
  end

  def remove_from_cart
    @cart = session[:shopping_cart] if session[:shopping_cart].present?
    @cart.delete(params[:id])
    flash[:success] = 'The item was removed successfully'
    session[:shopping_cart] = @cart
    # render json: { data: params[:id], status: 200 }
    redirect_to '/shopping_cart/index'
  end
end
