# frozen_string_literal: true

class CheckOutController < ApplicationController
  before_action :authenticate_user!
  def index
    redirect_to '/shopping_cart/index' if session['shopping_cart'].count == 0
    @user = current_user

    @cart = session[:shopping_cart] if session[:shopping_cart].present?
    @feature_ids = []

    @cart&.each_key { |key| @feature_ids.push(key) }

    @features = Feature.where(id: @feature_ids)

    @province = Province.find(@user.province_id)

    @sub_total = 0
    @features.each do |feature|
      @sub_total += feature.price.to_f * @cart[feature.id.to_s].to_f
    end

    @gst = @province.gst * 100
    @gst_total = @province.gst * @sub_total
    @pst = @province.pst * 100
    @pst_total = @province.pst * @sub_total
    @hst = @province.hst * 100
    @hst_total = @province.hst * @sub_total
    @total = @sub_total + @gst_total + @pst_total + @hst_total
  end
end
