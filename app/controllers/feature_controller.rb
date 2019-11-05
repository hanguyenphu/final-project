class FeatureController < ApplicationController
  def index

    
    @pagy, @features = pagy(Feature.all, items: 6)
    @categories = Category.all
    @statuses = Status.all
    if params[:category].present?  
      @category_id = params[:category]
      @pagy, @features = pagy(Feature.where(:category_id => @category_id))
    end
    
    if params[:status].present?  
      @status_id = params[:status]
      @pagy, @features = pagy(Feature.where(:status_id => @status_id ))
    end

    if params[:feature].present?  
      @feature = params[:feature].downcase
      @pagy, @features = pagy(Feature.where('lower(name) LIKE ?' , "%#{@feature}%" ))
    end
    
    if params[:category].present? && params[:status].present? 
      @category_id = params[:category]
      @status_id = params[:status]
      @pagy, @features = pagy(Feature.where(:category_id => @category_id, :status_id => @status_id))
    end
   
    

  end

  def show
    @feature = Feature.find(params[:id])
  end
end
