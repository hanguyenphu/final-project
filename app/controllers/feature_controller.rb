class FeatureController < ApplicationController
  def index
    @pagy, @features = pagy(Feature.all, items: 6)
  end

  def show
    @feature = Feature.find(params[:id])
  end
end
