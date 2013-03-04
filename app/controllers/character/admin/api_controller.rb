class Character::Admin::ApiController < Character::Admin::BaseController
  before_filter :set_model_class
  before_filter :set_form_template, only: %w( new edit create update )

  def set_form_template
    if template_exists?("#{@namespace}_form", "character/admin/api", false)
      @form_template = "character/admin/api/#{ @namespace }_form"
    else
      @form_template = "character/admin/api/generic_form"
    end
  end


  def set_model_class
    @model_slug  = params[:model_slug]
    @model_class = @model_slug.gsub('-', '::').constantize
    @namespace   = @model_class.name.underscore.gsub('/', '_').to_sym
  end


  def index
    @objects = @model_class.all
    render json: @objects
  end


  def show
    @object = @model_class.find(params[:id])
    render json: @object    
  end


  def new
    @object  = @model_class.new
    render @form_template, layout: false
  end  


  def edit
    @object = @model_class.find(params[:id])
    render @form_template, layout: false
  end


  def create
    @object = @model_class.new params[@namespace]

    if @object.save
      render json: @object
    else
      render @form_template, layout: false
    end
  end


  def update
    @object = @model_class.find(params[:id])
    
    if @object.update_attributes params[@namespace]
      render json: @object
    else
      render @form_template, layout: false
    end
  end


  def destroy
    @object = @model_class.find(params[:id])
    @object.destroy
    render json: 'ok'
  end


  def reorder
    # TODO: need to add reordarable check
    @model_class.reorder(params[:ids])
    render json: 'ok'
  end  
end


