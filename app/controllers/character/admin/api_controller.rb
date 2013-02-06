class Character::Admin::ApiController < Character::Admin::BaseController
  before_filter :set_model_class
  
  def set_model_class
    @model_slug  = params[:model_slug]
    
    # TODO: make a proper way of getting names out of url
    ### ============================================== ###
    @model_class = @model_slug.gsub('-', '::').constantize
    @namespace   = @model_slug.split('-').last().downcase() # singularize or something similar should be here
    ### ============================================== ###
  end

  def index
    @objects = @model_class.all
    render json: @objects
  end

  def new
    @object       = @model_class.new
    @form_action  = "/admin/api/#{ @model_slug }"
    render 'character/admin/forms/generic', layout: false
  end  

  def create
    @object = @model_class.create params[@namespace]
    render json: @object
  end

  def edit
    @object       = @model_class.find(params[:id])
    @form_action  = "/admin/api/#{ @namespace }/#{ params[:id] }"
    render 'character/admin/forms/generic', layout: false
  end

  def update
    @object = @model_class.find(params[:id])
    

    puts "\n\n\n\n\n"
    puts params#[@namespace]
    puts "\n\n\n\n\n"


    @object.update_attributes params[@namespace]

    render json: @object
  end

  def destroy
    @object = @model_class.find(params[:id])
    @object.destroy
    render json: 'ok'
  end

  def reorder
    # need to add reordarable check
    @model_class.reorder(params[:ids])
    render json: 'ok'
  end  
end


