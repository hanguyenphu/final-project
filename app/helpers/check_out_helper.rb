# frozen_string_literal: true

module CheckOutHelper
  def calculate_subtotal
    cart = session[:shopping_cart] if session[:shopping_cart].present?
    features = find_features
    sub_total = 0
    features.each do |feature|
      sub_total += feature.price.to_f * cart[feature.id.to_s].to_f
    end
    sub_total
  end

  def find_features
    cart = session[:shopping_cart] if session[:shopping_cart].present?
    feature_ids = []
    cart&.each_key { |key| feature_ids.push(key) }
    features = Feature.where(id: feature_ids)
    features
  end
end
