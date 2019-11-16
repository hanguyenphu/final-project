# frozen_string_literal: true

class FeatureController < ApplicationController
  def index
    @pagy, @features = pagy(Feature.all, items: 6)
    @categories = Category.all
    @statuses = Status.all
    if params[:category].present?
      @category_id = params[:category]
      @pagy, @features = pagy(Feature.where(category_id: @category_id), items: 6)
    end

    if params[:status].present?
      @status_id = params[:status]
      @pagy, @features = pagy(Feature.where(status_id: @status_id), items: 6)
    end

    if params[:feature].present? && params[:category].present?
      @feature = params[:feature].downcase
      @category_id = params[:category]
      @pagy, @features = pagy(Feature.where('category_id= ? and lower(name) LIKE ?', @category_id.to_s, "%#{@feature}%"), items: 6)
    end

    if params[:status].present? && params[:feature].present?
      @feature = params[:feature].downcase
      @status_id = params[:status]
      @pagy, @features = pagy(Feature.where('status_id= ? and lower(name) LIKE ?', @status_id.to_s, "%#{@feature}%"), items: 6)
    end

    if params[:category].present? && params[:status].present?
      @category_id = params[:category]
      @status_id = params[:status]
      @pagy, @features = pagy(Feature.where(category_id: @category_id, status_id: @status_id), items: 6)
    end

    if params[:category].present? && params[:status].present? && params[:feature].present?
      @feature = params[:feature].downcase
      @category_id = params[:category]
      @status_id = params[:status]
      @pagy, @features = pagy(Feature.where('status_id= ? and category_id = ? and lower(name) LIKE ?', @status_id.to_s, @category_id.to_s, "%#{@feature}%"), items: 6)
    end

    if !params[:category].present? && !params[:status].present? && params[:feature].present?
      @feature = params[:feature].downcase
      @pagy, @features = pagy(Feature.where('lower(name) LIKE ?', "%#{@feature}%"), items: 6)
    end
  end

  def show
    @feature = Feature.find(params[:id])
  end
end
