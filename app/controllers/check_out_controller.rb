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

  def create
    @total = params[:total].to_i
    @session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: [{
        name: "Total: ",
        amount: @total * 100,
        currency: 'cad',
        quantity:1
      }],
      success_url: check_out_success_url + '?session_id={CHECKOUT_SESSION_ID}', 
      cancel_url: check_out_index_url
    )

    respond_to do |format|
        format.js
    end

  end

  def success
   
    @session = Stripe::Checkout::Session.retrieve(params[:session_id])
    @payment_intent = Stripe::PaymentIntent.retrieve(@session.payment_intent)

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
    @invoice = Invoice.create(status: 'Paid', total: @total, province: @province.name, gst:@gst, 
    pst: @pst, hst: @hst, user_id: @user.id, payment_id:@payment_intent.id)
    @features.each do |feature|
      Solditem.create(name: feature.name, description:feature.description, price: feature.price, quantity: @cart[feature.id.to_s], category_id: feature.category_id, invoice_id: @invoice.id)
    end

    session.delete(:shopping_cart)
  end

  def cancel
  end

end
